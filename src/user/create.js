'use strict';

var async = require('async'),
	db = require('../database'),
	utils = require('../../public/src/utils'),
	validator = require('validator'),
	plugins = require('../plugins'),
	groups = require('../groups'),
	meta = require('../meta'),
	notifications = require('../notifications'),
	translator = require('../../public/src/modules/translator');

module.exports = function(User) {

	User.create = function(data, callback) {

		data.username = data.username.trim();
		data.userslug = utils.slugify(data.username);
		if (data.email !== undefined) {
			data.email = validator.escape(data.email.trim());
		}

		isDataValid(data, function(err) {
			if (err)  {
				return callback(err);
			}
			var gravatar = User.createGravatarURLFromEmail(data.email);
			var timestamp = Date.now();

			var userData = {
				'username': data.username,
				'userslug': data.userslug,
				'email': data.email,
				'joindate': timestamp,
				'picture': gravatar,
				'gravatarpicture': gravatar,
				'fullname': '',
				'location': '',
				'birthday': '',
				'website': '',
				'signature': '',
				'uploadedpicture': '',
				'profileviews': 0,
				'reputation': 0,
				'postcount': 0,
				'topiccount': 0,
				'lastposttime': 0,
				'banned': 0,
				'status': 'online'
			};

			async.parallel({
				renamedUsername: function(next) {
					renameUsername(userData, next);
				},
				customFields: function(next) {
					plugins.fireHook('filter:user.custom_fields', [], next);
				},
				userData: function(next) {
					plugins.fireHook('filter:user.create', userData, next);
				}
			}, function(err, results) {
				if (err) {
					return callback(err);
				}

				var customData = {};
				results.customFields.forEach(function(customField) {
					if (data[customField]) {
						customData[customField] = data[customField];
					}
				});

				userData = utils.merge(results.userData, customData);

				var userNameChanged = !!results.renamedUsername;

				if (userNameChanged) {
					userData.username = results.renamedUsername;
					userData.userslug = utils.slugify(results.renamedUsername);
				}

				async.waterfall([
					function(next) {
						db.incrObjectField('global', 'nextUid', next);
					},
					function(uid, next) {
						userData.uid = uid;
						db.setObject('user:' + uid, userData, next);
					}
				], function(err) {
					if (err) {
						return callback(err);
					}

					async.parallel([
						function(next) {
							db.incrObjectField('global', 'userCount', next);
						},
						function(next) {
							db.setObjectField('username:uid', userData.username, userData.uid, next);
						},
						function(next) {
							db.setObjectField('userslug:uid', userData.userslug, userData.uid, next);
						},
						function(next) {
							db.sortedSetAdd('users:joindate', timestamp, userData.uid, next);
						},
						function(next) {
							db.sortedSetsAdd(['users:postcount', 'users:reputation'], 0, userData.uid, next);
						},
						function(next) {
							groups.join('registered-users', userData.uid, next);
						},
						function(next) {
							if (userData.email) {
								db.setObjectField('email:uid', userData.email.toLowerCase(), userData.uid, next);
								if (parseInt(userData.uid, 10) !== 1 && parseInt(meta.config.requireEmailConfirmation, 10) === 1) {
									User.email.sendValidationEmail(userData.uid, userData.email);
								}
							} else {
								next();
							}
						},
						function(next) {
							if (!data.password) {
								return next();
							}

							User.hashPassword(data.password, function(err, hash) {
								if (err) {
									return next(err);
								}

								async.parallel([
									async.apply(User.setUserField, userData.uid, 'password', hash),
									async.apply(User.reset.updateExpiry, userData.uid)
								], next);
							});
						}
					], function(err) {
						if (err) {
							return callback(err);
						}
						if (userNameChanged) {
							User.notifications.sendNameChangeNotification(userData.uid, userData.username);
						}
						plugins.fireHook('action:user.create', userData);
						callback(null, userData.uid);
					});
				});
			});
		});
	};

	function isDataValid(userData, callback) {
		async.parallel({
			emailValid: function(next) {
				if (userData.email) {
					next(!utils.isEmailValid(userData.email) ? new Error('[[error:invalid-email]]') : null);
				} else {
					next();
				}
			},
			userNameValid: function(next) {
				next((!utils.isUserNameValid(userData.username) || !userData.userslug) ? new Error('[[error:invalid-username]]') : null);
			},
			passwordValid: function(next) {
				if (userData.password) {
					next(!utils.isPasswordValid(userData.password) ? new Error('[[error:invalid-password]]') : null);
				} else {
					next();
				}
			},
			emailAvailable: function(next) {
				if (userData.email) {
					User.email.available(userData.email, function(err, available) {
						if (err) {
							return next(err);
						}
						next(!available ? new Error('[[error:email-taken]]') : null);
					});
				} else {
					next();
				}
			}
		}, callback);
	}

	function renameUsername(userData, callback) {
		meta.userOrGroupExists(userData.userslug, function(err, exists) {
			if (err || !exists) {
				return callback(err);
			}

			var	newUsername = '';
			async.forever(function(next) {
				newUsername = userData.username + (Math.floor(Math.random() * 255) + 1);
				User.exists(newUsername, function(err, exists) {
					if (err) {
						return callback(err);
					}
					if (!exists) {
						next(newUsername);
					} else {
						next();
					}
				});
			}, function(username) {
				callback(null, username);
			});
		});
	}

};
