/** 
 * Copyright Intermesh
 * 
 * This file is part of Group-Office. You should have received a copy of the
 * Group-Office license along with Group-Office. See the file /LICENSE.TXT
 * 
 * If you have questions write an e-mail to info@intermesh.nl
 * 
 * @copyright Copyright Intermesh
 * @author Merijn Schering <mschering@intermesh.nl>
 * @author Wilmar van Beusekom <wilmar@intermesh.nl>
 */

GO.addressbook.createAddresslistGrids = function(){

	GO.addressbook.AddresslistContactsGrid = Ext.extend(function(config){

		if(!config)
		{
			config = {};
		}

		config.title=GO.addressbook.lang.contacts;

		this.selectContactDialog = new GO.addressbook.SelectContactDialog({
			handler: function(grid, allResults){
				if(!allResults){
					var selModel = grid.getSelectionModel();
					this.store.baseParams.add_keys = Ext.encode(selModel.selections.keys);
					this.store.load();
					delete this.store.baseParams.add_keys;
				}else
				{
					this.store.baseParams.add_search_result = Ext.encode(grid.store.baseParams);
					this.store.load();
					delete this.store.baseParams.add_search_result;
				}
			},
			scope : this
		});

		config.disabled=true;

		config.tbar = [
			{
				iconCls: 'btn-add',
				text: GO.lang.cmdAdd,
				cls: 'x-btn-text-icon',
				handler: function(){
					this.selectContactDialog.show();
				},
				scope: this
			},
			{
				iconCls: 'btn-add',
				text: GO.addressbook.lang.addEntireAddressbook,
				cls: 'x-btn-text-icon',
				handler: function(){
					if(!this.selectAddressbookWindow)
					{
						this.selectAddressbookWindow = new GO.addressbook.SelectAddressbookWindow();
						this.selectAddressbookWindow.on('select', function(addressbook_id){

							if(confirm(GO.addressbook.lang.confirmAddEntireAddressbook))
							{
								this.store.load({
									params:{'start': 0, 'add_addressbook_id': addressbook_id}
								});
							}
						}, this);
					}
					this.selectAddressbookWindow.show();
				},
				scope: this
			},
			{
				iconCls: 'btn-delete',
				text: GO.lang['cmdDelete'],
				cls: 'x-btn-text-icon',
				handler: function(){
					this.deleteSelected();
				},
				scope: this
			}
			];


		config.store = new GO.data.JsonStore({
				url: GO.url('addressbook/addresslist/contacts'),
				baseParams: {
					addresslist_id: '0'
				},
				root: 'results',
				id: 'id',
				totalProperty:'total',
				fields: ['id', 'name', 'company_name', 'email', 'home_phone', 'work_phone', 'cellular','addressbook_name'],
				remoteSort: true
			});


		config.paging=GO.settings.addresslists_store_forced_limit?parseInt(GO.settings.addresslists_store_forced_limit):true;
		config.border=false;
		var contactsColumnModel =  new Ext.grid.ColumnModel({
		defaults:{
			sortable:true
		},
		columns:[
			{
				header: GO.lang['strName'],
				dataIndex: 'name'
			},
			{
				header: GO.lang['strCompany'],
				dataIndex: 'company_name'
			},
			{
				header: GO.lang['strEmail'],
				dataIndex: 'email' ,
				width: 150,
				hidden:true
			},
			{
				header: GO.lang['strPhone'],
				dataIndex: 'home_phone' ,
				width: 100,
				hidden:true
			},
			{
				header: GO.lang['strWorkPhone'],
				dataIndex: 'work_phone' ,
				width: 100,
				hidden:true
			},
			{
				header: GO.lang['strWorkFax'],
				dataIndex: 'work_fax' ,
				width: 100,
				hidden:true
			},
			{
				header: GO.lang['strCellular'],
				dataIndex: 'cellular' ,
				width: 100,
				hidden:true
			},
			{
				header: GO.addressbook.lang['addressbook'],
				dataIndex: 'addressbook_name' ,
				width: 100,
				hidden:true
			}
		]
		});
		
		config.cm=contactsColumnModel;

		config.view=new Ext.grid.GridView({
			autoFill: true,
			forceFit: true,
			emptyText: GO.lang.strNoItems
		}),
		config.sm=new Ext.grid.RowSelectionModel();
		config.loadMask=true;

		config.paging=GO.settings.addresslists_store_forced_limit?parseInt(GO.settings.addresslists_store_forced_limit):true;

		GO.addressbook.AddresslistContactsGrid.superclass.constructor.call(this, config);

	}, GO.grid.GridPanel, {
		onShow : function(){
			if(!this.store.loaded)
			{
				this.store.load();
			}
			GO.addressbook.AddresslistContactsGrid.superclass.onShow.call(this);
		},
		setMailingId : function(addresslist_id)
		{
			this.store.baseParams['addresslist_id']=addresslist_id;
			this.store.loaded=false;
			this.setDisabled(addresslist_id==0||!addresslist_id);
		}
	});

	GO.addressbook.AddresslistCompaniesGrid = Ext.extend(function(config){

		if(!config)
		{
			config = {};
		}

		config.title=GO.addressbook.lang.companies;
		this.selectCompanyDialog = new GO.addressbook.SelectCompanyDialog({
			handler: function(grid, allResults){
				if(!allResults){
					var selModel = grid.getSelectionModel();
					this.store.baseParams.add_keys = Ext.encode(selModel.selections.keys);
					this.store.load();
					delete this.store.baseParams.add_keys;
				}else
				{
					this.store.baseParams.add_search_result = Ext.encode(grid.store.baseParams);
					this.store.load();
					delete this.store.baseParams.add_search_result;
				}
			},
			scope : this
		});

		config.disabled=true;

		config.tbar = [
			{
				iconCls: 'btn-add',
				text: GO.lang.cmdAdd,
				cls: 'x-btn-text-icon',
				handler: function(){
					this.selectCompanyDialog.show();
				},
				scope: this
			},
			{
				iconCls: 'btn-add',
				text: GO.addressbook.lang.addEntireAddressbook,
				cls: 'x-btn-text-icon',
				handler: function(){
					if(!this.selectAddressbookWindow)
					{
						this.selectAddressbookWindow = new GO.addressbook.SelectAddressbookWindow();
						this.selectAddressbookWindow.on('select', function(addressbook_id){

							if(confirm(GO.addressbook.lang.confirmAddEntireAddressbook))
							{
								this.store.load({
									params:{'start': 0, 'add_addressbook_id': addressbook_id}
								});
							}

						}, this);
					}
					this.selectAddressbookWindow.show();
				},
				scope: this
			},
			{
				iconCls: 'btn-delete',
				text: GO.lang['cmdDelete'],
				cls: 'x-btn-text-icon',
				handler: function(){
					this.deleteSelected();
				},
				scope: this
			}
			];

		config.store = new GO.data.JsonStore({
			url: GO.url('addressbook/addresslist/companies'),
			baseParams: {
				addresslist_id: '0'
			},
			root: 'results',
			id: 'id',
			totalProperty:'total',
			fields: ['id', 'name', 'homepage', 'email', 'phone', 'fax','addressbook_name'],
			remoteSort: true
		});


		config.border=false;
		config.paging=GO.settings.addresslists_store_forced_limit?parseInt(GO.settings.addresslists_store_forced_limit):true;

		var companiesColumnModel =  new Ext.grid.ColumnModel({
		defaults:{
			sortable:true
		},
		columns:[
			{
				header: GO.lang['strName'],
				dataIndex: 'name'
			},
			{
				header: GO.lang['strEmail'],
				dataIndex: 'email' ,
				width: 150,
				hidden:true
			},
			{
				header: GO.lang['strHomepage'],
				dataIndex: 'homepage' ,
				width: 100,
				hidden:true
			},
			{
				header: GO.lang['strPhone'],
				dataIndex: 'phone' ,
				width: 100
			},
			{
				header: GO.lang['strFax'],
				dataIndex: 'fax' ,
				width: 100,
				hidden:true
			},
			{
				header: GO.addressbook.lang['addressbook'],
				dataIndex: 'addressbook_name' ,
				width: 100,
				hidden:true
			}
		]
		});
		
		config.cm=companiesColumnModel;

		config.view=new Ext.grid.GridView({
			autoFill: true,
			forceFit: true,
			emptyText: GO.lang.strNoItems
		}),
		config.sm=new Ext.grid.RowSelectionModel();
		config.loadMask=true;

		GO.addressbook.CompaniesGrid.superclass.constructor.call(this, config);

	},GO.grid.GridPanel, {
		onShow : function(){
			if(!this.store.loaded)
			{
				this.store.load();
			}
			GO.addressbook.AddresslistContactsGrid.superclass.onShow.call(this);
		},


		setMailingId : function(addresslist_id)
		{
			this.store.baseParams['addresslist_id']=addresslist_id;
			this.store.loaded=false;
			this.setDisabled(addresslist_id==0||!addresslist_id);
		}
	});

};	
		


if(!GO.addressbook)
{
	GO.moduleManager.onModuleReady('addressbook', GO.addressbook.createAddresslistGrids);
}else
{
	GO.addressbook.createAddresslistGrids();
} 
