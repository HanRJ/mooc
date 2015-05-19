<div class="unread">

	<div class="clearfix">
		<div class="pull-left">
<ol class="breadcrumb">
	<!-- BEGIN breadcrumbs -->
	<li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb" <!-- IF @last -->class="active"<!-- ENDIF @last -->>
		<!-- IF !@last --><a href="{breadcrumbs.url}" itemprop="url"><!-- ENDIF !@last -->
			<span itemprop="title">
				{breadcrumbs.text}
				<!-- IF @last -->
				<!-- IF !feeds:disableRSS -->
				<!-- IF rssFeedUrl --><a target="_blank" href="{rssFeedUrl}"><i class="fa fa-rss-square"></i></a><!-- ENDIF rssFeedUrl --><!-- ENDIF !feeds:disableRSS -->
				<!-- ENDIF @last -->
			</span>
		<!-- IF !@last --></a><!-- ENDIF !@last -->
	</li>
	<!-- END breadcrumbs -->
</ol>
		</div>

		<div class="markread btn-group pull-right<!-- IF !topics.length --> hidden<!-- ENDIF !topics.length -->">
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				[[unread:mark_as_read]] <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">

				<li role="presentation">
					<a id="markSelectedRead" role="menuitem" tabindex="-1" href="#">[[unread:selected]]</a>
				</li>

				<li role="presentation">
					<a id="markAllRead" role="menuitem" tabindex="-1" href="#">[[unread:all]]</a>
				</li>
				<li class="divider"></li>
			</ul>
		</div>
	</div>

	<hr />

	<div class="category">
		<div id="category-no-topics" class="alert alert-warning <!-- IF topics.length -->hidden<!-- ENDIF topics.length -->">
			<strong>[[unread:no_unread_topics]]</strong>
		</div>

		<a href="{relative_path}/unread">
			<div class="alert alert-warning hide" id="new-topics-alert"></div>
		</a>

<ul component="category" itemscope itemtype="http://www.schema.org/ItemList" data-nextstart="{nextStart}">
	<meta itemprop="itemListOrder" content="descending">
	<!-- BEGIN topics -->
	<li component="category/topic" class="row clearfix {function.generateTopicClass}"data-tid="{topics.tid}" data-index="{topics.index}" data-cid="{topics.cid}" itemprop="itemListElement">
		<meta itemprop="name" content="{function.stripTags, title}">

		<div class="col-md-7 col-sm-9 col-xs-11 content">
			<div class="avatar hidden-sm hidden-xs pull-left">
				<!-- IF showSelect -->
					<div class="select fa-square-o">
						<img src="{topics.user.picture}" class="img-circle user-img" />
						<i class="fa fa-check"></i>
					</div>
				<!-- ELSE -->
					<a href="{relative_path}/user/{topics.user.userslug}" class="pull-left">
						<img src="{topics.user.picture}" class="img-circle user-img" title="{topics.user.username}"/>
					</a>
				<!-- ENDIF showSelect -->
			</div>

			<h1 component="topic/header" class="title pull-left">
				<i component="topic/pinned" class="fa fa-thumb-tack <!-- IF !topics.pinned -->hide<!-- ENDIF !topics.pinned -->"></i>
				<i component="topic/locked" class="fa fa-lock <!-- IF !topics.locked -->hide<!-- ENDIF !topics.locked -->"></i>
				<a href="{relative_path}/topic/{topics.slug}" itemprop="url">{topics.title}</a><br />

				<!-- IF template.category -->
				<small>
					<!-- IF topics.user.userslug -->
					[[global:posted_ago_by, <span class="timeago" title="{topics.relativeTime}"></span>, <strong>{topics.user.username}</strong>]]
					<!-- ELSE -->
					[[global:posted_ago_by_guest, <span class="timeago" title="{topics.relativeTime}"></span>]]
					<!-- ENDIF topics.user.userslug -->
				</small>
				<!-- ELSE -->
				<small>
					<!-- IF topics.user.userslug -->
					[[global:posted_in_ago_by, <a href="{relative_path}/category/{topics.category.slug}"><i class="fa {topics.category.icon}"></i> {topics.category.name}</a>, <span class="timeago" title="{topics.relativeTime}"></span>, <strong>{topics.user.username}</strong>]]
					<!-- ELSE -->
					[[global:posted_in_ago_by_guest, <a href="{relative_path}/category/{topics.category.slug}"><i class="fa {topics.category.icon}"></i> {topics.category.name}</a>, <span class="timeago" title="{topics.relativeTime}"></span>]]
					<!-- ENDIF topics.user.userslug -->
				</small>
				<!-- ENDIF template.category -->
			</h1>
		</div>

		<div class="col-md-1 hidden-sm hidden-xs stats">
			<span class="human-readable-number" title="{topics.postcount}">{topics.postcount}</span><br />
			<small>[[global:posts]]</small>
		</div>
		<div class="col-md-1 hidden-sm hidden-xs stats">
			<span class="human-readable-number" title="{topics.viewcount}">{topics.viewcount}</span><br />
			<small>[[global:views]]</small>
		</div>
		<div class="col-md-3 col-sm-3 col-xs-1 teaser">
			<div class="card" style="border-color: {bgColor}">
				<!-- IF topics.unreplied -->
				<p class="hidden-xs">
					[[category:no_replies]]
				</p>
				<!-- ELSE -->
				<p class="hidden-xs">
					<strong>{topics.teaser.user.username}</strong>
					<a class="permalink" href="{relative_path}/topic/{topics.slug}/{topics.teaser.index}">
						<small class="timeago" title="{topics.teaser.timestamp}"></small>
					</a>
				</p>
				<div class="post-content">
					{topics.teaser.content}
				</div>
				<!-- ENDIF topics.unreplied -->
			</div>
		</div>
	</li>
	<!-- END topics -->
</ul>
		<button id="load-more-btn" class="btn btn-primary hide">[[unread:load_more]]</button>
	</div>
</div>
