<div class="col-lg-9">

<div class="panel panel-default">
	<div class="panel-heading">Crawlability Settings</div>
	<div class="panel-body">
		<form>
			<strong>Custom Robots.txt <small>Leave blank for default</small></strong><br />
			<textarea class="form-control" data-field="robots.txt"></textarea>
		</form>
	</div>
</div>

<div class="panel panel-default">
	<div class="panel-heading">Sitemap & Feed Settings</div>
	<div class="panel-body">
		<form>
			<div class="checkbox">
				<label>
					<input type="checkbox" data-field="feeds:disableRSS"> <strong>Disable RSS Feeds</strong>
				</label>
			</div>

			<div class="checkbox">
				<label>
					<input type="checkbox" data-field="feeds:disableSitemap"> <strong>Disable Sitemap.xml</strong>
				</label>
			</div>

			<div class="form-group">
				<label>Number of Topic to Display in Sitemap</label>
				<input class="form-control" type="text" placeholder="" data-field="sitemapTopics" />
			</div>

			<button id="clear-sitemap-cache" class="btn btn-warning">Clear Sitemap Cache</button>

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
