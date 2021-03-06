/** 
 * Copyright Intermesh
 * 
 * This file is part of Group-Office. You should have received a copy of the
 * Group-Office license along with Group-Office. See the file /LICENSE.TXT
 * 
 * If you have questions write an e-mail to info@intermesh.nl
 * 
 * @copyright Copyright Intermesh
 * @version $Id: BookDialog.js 22435 2017-07-31 08:16:21Z johan $
 * @author Merijn Schering <mschering@intermesh.nl>
 */

GO.billing.BookDialog = function(config){
	
	
	if(!config)
	{
		config={};
	}
	
	
	this.buildForm();
	
	var focusFirstField = function(){
		this.propertiesPanel.items.items[0].focus();
	};
	
	
	config.maximizable=true;
	config.layout='fit';
	config.modal=false;
	config.resizable=true;
	config.width=900;
	config.height=600;
	config.closeAction='hide';
	config.title= GO.billing.lang.book;        
	config.items= this.formPanel;
	config.focus= focusFirstField.createDelegate(this);
	config.buttons=[{
		text: GO.lang['cmdOk'],
		handler: function(){
			this.submitForm(true);
		},
		scope: this
	},{
		text: GO.lang['cmdApply'],
		handler: function(){
			this.submitForm();
		},
		scope:this
	},{
		text: GO.lang['cmdClose'],
		handler: function(){
			this.hide();
		},
		scope:this
	}
	];
	
	GO.billing.BookDialog.superclass.constructor.call(this, config);
	this.addEvents({
		'save' : true
	});
}
Ext.extend(GO.billing.BookDialog, GO.Window,{
	
	show : function (book_id) {
		if(!this.rendered)
		{
			this.render(Ext.getBody());
		}
				
		this.tabPanel.setActiveTab(0);		
		
		if(!book_id)
		{
			book_id=0;			
		}
			
		this.setBookId(book_id);
		
		if(this.book_id>0)
		{
			GO.billing.orderStatusSelectStore.baseParams['book_id'] = this.book_id;
			GO.billing.orderStatusSelectStore.reload();
			this.formPanel.load({
				url : GO.url("billing/book/load"),
				
				success:function(form, action)
				{
					this.readPermissionsTab.setAcl(action.result.data.acl_id);

//					this.selectUser.setRemoteText(action.result.remoteComboTexts.user_id);
//					this.selectAddressbook.setRemoteText(action.result.remoteComboTexts.addressbook_id);
					
					GO.dialog.TabbedFormDialog.prototype.setRemoteComboTexts.call(this, action);
					
					GO.billing.BookDialog.superclass.show.call(this);
				},
				failure:function(form, action)
				{
					GO.errorDialog.show(action.result.feedback)
				},
				scope: this
				
			});
		}else 
		{			
			this.formPanel.form.reset();
			this.readPermissionsTab.setAcl(0);
			
			GO.billing.BookDialog.superclass.show.call(this);
		}
	},
	
	setBookId : function(book_id)
	{
		this.formPanel.form.baseParams['id']=book_id;
		this.book_id=book_id;
		
		this.orderStatusesTab.setBookId(book_id);
		this.costCodesGrid.setBookId(book_id);
		this.importSettingsPanel.setBookId(book_id);
		this.taxRatesGrid.setBookId(book_id);
		
		if(book_id>0)
		{
			this.templatesTab.setDisabled(false);
			this.docTemplatesTab.setDisabled(false);
			this.specialStatusesTab.setDisabled(false);
			this.costCodesGrid.setDisabled(false);
			this.taxRatesGrid.setDisabled(false);
			this.templatesTab.store.baseParams.book_id=this.docTemplatesTab.store.baseParams.book_id=book_id;
			GO.billing.orderStatusSelectStore.baseParams.book_id=book_id;

			this.templatesTab.store.on('load', function(){
				this.body.unmask();
			}, this);

			this.docTemplatesTab.store.on('load', function(){
				this.body.unmask();
			}, this);					

			this.body.mask(GO.lang.waitMsgLoad);

			this.templatesTab.store.load();
			this.docTemplatesTab.store.load();
		}else
		{
			this.templatesTab.setDisabled(true);
			this.docTemplatesTab.setDisabled(true);
			this.specialStatusesTab.setDisabled(true);
			this.costCodesGrid.setDisabled(true);
			this.taxRatesGrid.setDisabled(true);
		}		
	},
	
	submitForm : function(hide){
		this.formPanel.form.submit(
		{
			url:GO.url("billing/book/submit"),
			waitMsg:GO.lang['waitMsgSave'],
			success:function(form, action){
								
				this.fireEvent('save', this);
				
				if(hide)
				{
					this.hide();	
				}else
				{
					if(action.result.id)
					{
						this.setBookId(action.result.id);
						
						this.readPermissionsTab.setAcl(action.result.acl_id);
					}
				}									
			},		
			failure: function(form, action) {
				if(action.failureType == 'client')
				{					
					Ext.MessageBox.alert(GO.lang['strError'], GO.lang['strErrorsInForm']);			
				} else {
					Ext.MessageBox.alert(GO.lang['strError'], action.result.feedback);
				}
			},
			scope: this
		});
		
	},
	
	buildForm : function () {
		
		
		var propItems = [
//		this.selectUser = new GO.form.SelectUser({
//			fieldLabel: GO.lang['strUser'],
//			disabled: !GO.settings.modules['billing']['write_permission'],
//			value: GO.settings.user_id,
//			anchor: '-20'
//		}),
		
			{
			xtype: 'textfield',
			name: 'name',
			anchor: '-20',
			allowBlank:false,
			fieldLabel: GO.lang.strName
		},{
			xtype: 'textfield',
			name: 'order_id_prefix',
			width: 100,
			allowBlank:false,
			fieldLabel: GO.billing.lang.orderIdPrefix,
			value: "%y-"
		},{
			xtype: 'numberfield',
			name: 'order_id_length',
			width:100,
			decimals: 0,
			allowBlank:false,
			fieldLabel: GO.billing.lang.orderIdlength
		},{
			xtype: 'textfield',
			maskRe: /([1-9][0-9]*)|([0]+)/, // number cant start with 0
			//decimals: 0,
			name: 'next_id',
			value: 0,
			style: 'text-align: right;',
			width: 100,
			allowBlank:false,
			fieldLabel: GO.billing.lang.nextId
		},{
			xtype: 'numberfield',
			name: 'default_vat',
			width: 100,
			allowBlank:false,
			fieldLabel: GO.billing.lang.defaultVat
		},{
			xtype: 'textfield',
			name: 'currency',
			width: 100,
			allowBlank:false,
			fieldLabel: GO.billing.lang.currency,
			value: GO.settings.currency
		},
//		{
//			xtype: 'textarea',
//			name: 'order_csv_template',
//			anchor: '-20',
//			allowBlank:true,
//			fieldLabel: GO.billing.lang.orderCsvTemplate
//		},{
//			xtype: 'textarea',
//			name: 'item_csv_template',
//			anchor: '-20',
//			allowBlank:true,
//			fieldLabel: GO.billing.lang.itemCsvTemplate
//		},
		new GO.form.SelectCountry({
			name: 'country_text',
			hiddenName: 'country',
			anchor:'-20',
			allowBlank:false,
			value:GO.settings.country,
			fieldLabel: GO.lang.strCountry
		}),
//		{
//			xtype: 'textfield',
//			name: 'bcc',
//			anchor: '-20',
//			allowBlank:true,
//			fieldLabel: GO.billing.lang.bcc
//		},
		{
			xtype: 'textfield',
			name: 'sender_email',
			anchor: '-20',
			vtype:'email',
			fieldLabel: GO.billing.lang.sender_email
		},{
			xtype: 'textfield',
			name: 'sender_name',
			anchor: '-20',
			fieldLabel: GO.billing.lang.sender_name
		},{
			xtype: 'numberfield',
			name: 'default_due_days',
			anchor: '-20',
			allowBlank:false,
			decimals: 0,
			fieldLabel: GO.billing.lang.defaultDueDays
		}];
			
		if(GO.tasks)
		{
			propItems.push({
				xtype: 'numberfield',
				decimals:0,
				name: 'call_after_days',
				anchor: '-20',
				allowBlank:true,
				fieldLabel: GO.billing.lang.callAfterDays
			});
		}

		propItems.push({
			xtype:'xcheckbox',
			boxLabel : GO.billing.lang.purchaseOrdersBook,
			labelSeparator : '',
			name : 'is_purchase_orders_book',
//			allowBlank : true,
			hideLabel : true
		});
		
		propItems.push({
			xtype:'xcheckbox',
			boxLabel : GO.billing.lang.allowDelete,
			labelSeparator : '',
			name : 'allow_delete',
//			allowBlank : true,
			hideLabel : true
		});


		propItems.push(this.selectAddressbook = new GO.form.ComboBoxReset({
			fieldLabel:GO.billing.lang.fixedAddressbook,
			anchor: '-20',
			displayField: 'name',
			valueField: 'id',
			triggerAction:'all',
			mode:'remote',
			editable: true,
			selectOnFocus:true,
			forceSelection: true,
			typeAhead: true,
			emptyText:GO.billing.lang.useAny,
			hiddenName:"addressbook_id",
			pageSize: parseInt(GO.settings.max_rows_list),
			store:new GO.data.JsonStore({
				url: GO.url("addressbook/addressbook/store"),
				baseParams: {
					'permissionLevel' : GO.permissionLevels.write,
					limit:parseInt(GO.settings['max_rows_list'])
				},
				fields: ['id','name'],
				remoteSort: true
			})
		}));
		
		propItems.push({
			xtype:'xcheckbox',
			boxLabel : GO.billing.lang.showSalesAgents,
			labelSeparator : '',
			name : 'show_sales_agents',
//			allowBlank : true,
			hideLabel : true
		});
		
		this.propertiesPanel = new Ext.Panel({
			url: GO.settings.modules.billing.url+'action.php',
			border: false,
			baseParams: {
				task: 'book'
			},
			labelWidth:120,
			title:GO.lang['strProperties'],			
			cls:'go-form-panel',			
			layout:'form',
			autoScroll:true,
			items: propItems				
		});
		var items  = [this.propertiesPanel];
		
		this.templatesTab = new GO.billing.TemplatesGrid();
		items.push(this.templatesTab);

		this.docTemplatesTab = new GO.billing.DocTemplatesGrid();
		items.push(this.docTemplatesTab);
    
		this.orderStatusesTab = new GO.billing.OrderStatusesGrid();
		items.push(this.orderStatusesTab);

		this.specialStatusesTab = new GO.billing.SpecialStatusesPanel();
		items.push(this.specialStatusesTab);

//		this.costCodesGrid = new GO.billing.CostCodesGrid();
		this.costCodesGrid = new GO.billing.SettingsCostCodeGrid();
		items.push(this.costCodesGrid);       
		
		this.taxRatesGrid = new GO.billing.SettingsTaxRateGrid();
		items.push(this.taxRatesGrid);       
		
		this.importSettingsPanel = new GO.billing.ImportSettingsPanel();
		items.push(this.importSettingsPanel);       
		
		this.readPermissionsTab = new GO.grid.PermissionsPanel();
		items.push(this.readPermissionsTab);		
 
		this.tabPanel = new Ext.TabPanel({
			activeTab: 0,
			deferredRender: false,
			border: false,
			items: items,
			enableTabScroll:true,
			anchor: '100% 100%'
		}) ;
    
    
		this.formPanel = new Ext.form.FormPanel({
			waitMsgTarget:true,
			url: GO.settings.modules.billing.url+'action.php',
			border: false,
			baseParams: {
				task: 'book'
			},
			items:this.tabPanel				
		});
    
    
	}
});