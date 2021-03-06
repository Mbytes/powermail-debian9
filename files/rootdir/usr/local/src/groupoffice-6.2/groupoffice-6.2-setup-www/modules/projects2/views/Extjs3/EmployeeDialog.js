/**
 * Copyright Intermesh
 *
 * This file is part of Group-Office. You should have received a copy of the
 * Group-Office license along with Group-Office. See the file /LICENSE.TXT
 *
 * If you have questions write an e-mail to info@intermesh.nl
 *
 * @version $Id: EmployeeDialog.js 23455 2018-03-01 14:24:03Z mdhart $
 * @copyright Copyright Intermesh
 * @author Michael de Hart <mdhart@intermesh.nl>
 */
GO.projects2.EmployeeDialog = Ext.extend(GO.dialog.TabbedFormDialog, {

	initComponent: function() {

		Ext.apply(this, {
			layout: 'fit',
			title: GO.projects2.lang['employee'],
			width: 480,
			height: 550,
			resizable: false,
			remoteModelIdName:'user_id',
			formControllerUrl: 'projects2/employee'
		});

		GO.projects2.EmployeeDialog.superclass.initComponent.call(this);
	},
	buildForm: function() {

this.externalRateStore = new Ext.data.ArrayStore({
			id: 'activity_id',
			fields: ['activity_name','external_rate','activity_id'],
			data : []
		});
		
		var unusedActiviteisStore = new GO.data.JsonStore({
			url:GO.url("projects2/standardTask/store"),
			fields:['id','code','name', 'description', 'units', 'disabled','is_billable'],
			remoteSort:true
		});
		unusedActiviteisStore.on('load', function(store, records, options){
			store.filterBy(function(record, id) {
				return record.data.is_billable == 1;
			});
		});
		unusedActiviteisStore.load();
		
		this.externalRateGrid = new Ext.grid.EditorGridPanel({
					title: GO.projects2.lang['extRatePerActivity'],
					clicksToEdit: 1,
					height: 300,
					store: this.externalRateStore,
					viewConfig: {
						forceFit: true,
						emptyText: GO.projects2.lang['noRatePerActivityConfigured']
					},
					cm: new Ext.grid.ColumnModel({
						defaults: {
							sortable: false
						},
						columns: [{
							header: GO.projects2.lang['activity'],
							name: 'activity_name'
						},{
							header: GO.projects2.lang['rate'],
							align: 'right',
							dataIndex: 'external_rate',
							renderer: GO.util.format.valuta,
							editor: new Ext.form.NumberField()
						}]
					}),
					tbar: [{
						xtype:'combo',
						editable: false,
						iconCls: 'btn-add',
						displayField: 'name',
						valueField: 'id',
						mode: 'local',
						triggerAction: 'all',
						width:100,
						listWidth: 400,
						store: unusedActiviteisStore,
						value: GO.lang['cmdAdd'],
						listeners: {
							expand: function(cb) {
								cb.store.filterBy(function(record, id) {
									if(record.data.is_billable != 1){
										return false;
									}
									return this.externalRateStore.find('activity_id', id) === -1;
								},this);
							},
							select: function(cb, record) {

								this.externalRateGrid.stopEditing();
								this.externalRateGrid.store.insert(0, new Ext.data.Record({
									activity_id: record.data.id,
									activity_name: record.data.name,
									external_rate: ''
								}));
								this.externalRateGrid.startEditing(0, 1);
								
								cb.setValue(GO.lang['cmdAdd']);
							},
							scope: this
						},
					},' ',{
						iconCls: 'btn-delete',
						text: GO.lang['cmdDelete'],
						handler: function () {
							var sel = this.externalRateGrid.selModel.getSelectedCell();
							if (sel) {
								this.externalRateGrid.store.removeAt(sel[0]);
							}
						},
						scope: this
					}],
				});
		

		this.formPanel = new Ext.Panel({
			cls: 'go-form-panel',
			layout: 'form',
			labelWidth: 140,
			items: [
			this.selectUser = new GO.form.SelectUser({
				hiddenName:'add_user_id',
				startBlank:true,
				value:0
			})
			,{
				xtype: 'datetime',
				fieldLabel: GO.projects2.lang['entriesClosedTill'],
				name: 'closed_entries_time',
				allowBlank: true
			},{
				xtype: 'numberfield',
				fieldLabel: GO.projects2.lang['externalFee'],
				name: 'external_fee'
			},{
				xtype: 'numberfield',
				fieldLabel: GO.projects2.lang['internalFee'],
				name: 'internal_fee'
			},
			this.externalRateGrid
			]
		});
		this.addPanel(this.formPanel);
	},
	afterShowAndLoad : function(remoteModelId, config){
		this.selectUser.setDisabled(remoteModelId>0);
	},
	
	afterLoad : function(remoteModelId, config, action){
		this.populateExternalRates(action.result.data.externalRates);
	},
	
	beforeSubmit : function(params){

		rates = [];
		this.externalRateStore.each(function(record){
			rates.push(record.data);
		},this);
		params.externalRates = Ext.encode(rates);

		GO.projects2.EmployeeDialog.superclass.beforeSubmit.call(this, params);
	},
	
	populateExternalRates : function(items){
		this.externalRateStore.removeAll();
		for(var i=0; i < items.length; i++){
			
			var r = new Ext.data.Record({
				external_rate:items[i].external_rate,
				activity_id:items[i].activity_id,
				activity_name: items[i].activity_name
			});
			this.externalRateGrid.stopEditing();
			this.externalRateStore.insert(0, r);
		}
	}
});