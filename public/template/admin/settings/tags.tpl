<div class="col-lg-9">

<div class="panel panel-default">
	<div class="panel-heading">Tag Settings</div>
	<div class="panel-body">
		<form>
			<div class="checkbox">
				<label>
					<input type="checkbox" data-field="privateTagListing"> Make the tags list private
				</label>
			</div>
			<div class="form-group">
				<label for="tagsPerTopics">Tags per Topic</label>
				<input id="tagsPerTopics" type="text" class="form-control" value="5" data-field="tagsPerTopic">
			</div>
			<div class="form-group">
				<label for="minimumTagLength">Minimum Tag Length</label>
				<input id="minimumTagLength" type="text" class="form-control" value="3" data-field="minimumTagLength">
			</div>
			<div class="form-group">
				<label for="maximumTagLength">Maximum Tag Length</label>
				<input id="maximumTagLength" type="text" class="form-control" value="15" data-field="maximumTagLength">
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
