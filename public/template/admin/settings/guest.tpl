<div class="col-lg-9">

<div class="panel panel-default">
	<div class="panel-heading">Guests</div>
	<div class="panel-body">
		<p class="alert alert-info">
			These options affect guest users as a whole. Control over which categories a guest can see or post to is handled in
			the categories themselves
		</p>

		<form role="form">
			<div class="checkbox">
				<label>
					<input type="checkbox" data-field="allowGuestHandles"> <strong>Allow guest handles</strong>
					<p class="help-block">
						This option exposes a new field that allows guests to pick a name to associate with each post they make. If disabled,
						the will simply be called "Guest" (or the equivalent in the forum&apos;s selected language)
					</p>
				</label>
			</div>
		</form>
	</div>
</div>

</div>

<div class="col-lg-3 acp-sidebar">
	<div class="panel panel-default">
		<div class="panel-heading">Save Settings</div>
		<div class="panel-body">
			<button class="btn btn-primary btn-md" id="save">Save Changes</button>
			<button class="btn btn-warning btn-md" id="revert">Revert Changes</button>
		</div>
	</div>
</div>

<script>
	require(['admin/settings'], function(Settings) {
		Settings.prepare();
	});
</script>
