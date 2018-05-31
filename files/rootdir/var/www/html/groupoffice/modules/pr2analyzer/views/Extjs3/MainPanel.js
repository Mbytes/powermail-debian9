/* 
 * There is no mainpanel this will just add a button the the ProjectPanel new Menu
 */
GO.moduleManager.onModuleReady('projects2', function () {
	Ext.override(GO.projects2.MainPanel, {

		initComponent: GO.projects2.MainPanel.prototype.initComponent.createInterceptor(function () {

			//add survey view to nav
			var btnAnalizer = new Ext.Button({
				cls: 'x-btn-text-icon',
				iconCls: 'pr2a-btn-report',
				text: GO.pr2analyzer.lang.analyze,
				handler: function () {
					this.analizeDialog.show();
				},
				hidden: GO.settings.modules.projects2.permission_level<GO.projects2.permissionLevelFinance,
				scope: this
			});
			this.tbar.add(btnAnalizer);


			this.reportGrid = new GO.pr2analyzer.ReportGrid({
				border: false,
				id: this.id + '-survey',
				region: 'center'
			});


			this.typesMultiSelect = new GO.grid.MultiSelectGrid({
				region: 'west',
				width: 180,
				id: 'pr2_analyze_select_type',
				title: GO.projects2.lang.projectType,
				loadMask: true,
				store: GO.projects2.typesStore2,
				split: true,
				allowNoSelection: true,
				relatedStore: this.reportGrid.store
			});


			this.analizeDialog = new GO.Window({
				title: GO.pr2analyzer.lang.analyze,
				maximizable: true,
				height: 650,
				width: 1100,
				layout: 'border',
				listeners: {
					show: function () {
						GO.projects2.typesStore2.load();
						this.reportGrid.store.reload();
					},
					scope: this
				},
				scope: this,
				items: [
					this.typesMultiSelect,
					this.reportGrid
				]
			});

		})

	});
});