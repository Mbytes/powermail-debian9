/** 
 * Copyright Intermesh
 * 
 * This file is part of Group-Office. You should have received a copy of the
 * Group-Office license along with Group-Office. See the file /LICENSE.TXT
 * 
 * If you have questions write an e-mail to info@intermesh.nl
 * 
 * @version $Id: IncomeDialog.js 23356 2018-02-01 11:22:20Z mschering $
 * @copyright Copyright Intermesh
 * @author Michael de Hart <mdhart@intermesh.nl>
 */
 
GO.projects2.IncomeDialog = Ext.extend(GO.dialog.TabbedFormDialog , {
		
	jsonPost: true,
	_projectId: 0,
		
	initComponent : function(){
		
		Ext.apply(this, {
			titleField:'description',
			title:GO.projects2.lang.income,
			height: 800,
			width: 600,
			formControllerUrl: 'projects2/income'
		});
		
		GO.projects2.IncomeDialog.superclass.initComponent.call(this);	
	},
	
	toggleContractFields : function(visible){
		this.repeatComp.setVisible(visible);
		this.contractEndDate.setVisible(visible);
		this.contractNotificationComp.setVisible(visible);
		this.notificationText.setVisible(visible);
	},
	
	buildForm : function () {
		this.projectPathField = new Ext.form.DisplayField({
			name: 'income.project_path',
			fieldLabel: GO.projects2.lang.project
		});
		this.isContractCheck = new Ext.ux.form.XCheckbox({
			name: 'income.is_contract',
			fieldLabel: GO.projects2.lang.contract,
			listeners:{
				check: function(cmp,val){
					this.toggleContractFields(val);
				},
				scope:this
			}
		});
		
		this.contractEndDate = new Ext.form.DateField({
			name: 'income.contract_end',
			width:205,
			maxLength: 50,
			allowBlank:true,
			fieldLabel: GO.projects2.lang.contractEnd,
			value: new Date(),
			hidden: true
		});
		
		this.repeatAmount = new GO.form.NumberField({
			decimals:0,
			name : 'income.contract_repeat_amount',
			minValue:1,
			width : 50,
			value : '1'
		});

		this.repeatFreq = new Ext.form.ComboBox({
			hiddenName : 'income.contract_repeat_freq',
			triggerAction : 'all',
			editable : false,
			selectOnFocus : true,
			width : 150,
			forceSelection : true,
			mode : 'local',
			value : '',
			valueField : 'value',
			displayField : 'text',
			store : new Ext.data.SimpleStore({
				fields : ['value', 'text'],
				data : [['', GO.lang.noRecurrence],
				['DAYS', GO.lang.strDays],
				['WEEKS', GO.lang.strWeeks],
				['MONTHS', GO.lang.strMonths],
				['YEARS', GO.lang.strYears]]
			}),
			hideLabel : true
		});
//
//		this.repeatFreq.on('select', function(combo, record) {
//			this.checkDateInput();
//			this.changeRepeat(record.data.value);
//		}, this);

		this.repeatComp = new Ext.form.CompositeField({
			fieldLabel : GO.projects2.lang.repeat,
			items : [this.repeatAmount,this.repeatFreq],
			hidden: true
		});
		
		this.notificationText = new GO.form.PlainField({
			value: GO.projects2.lang.contractNotificationText
		});

		this.notificationDays = new GO.form.NumberField({
			decimals:0,
			name : 'income.contract_end_notification_days',
			minValue:0,
			width : 50,
			value : '0'
		});
		
		this.notificationActive = new Ext.ux.form.XCheckbox({
			name: 'income.contract_end_notification_active',
			boxLabel: GO.projects2.lang.active,
			flex: 1
		});
		
		this.selectnotificationTemplate = new GO.form.ComboBoxReset({
			hiddenName:'income.contract_end_notification_template',
//			fieldLabel:GO.projects2.lang.select_template,
			valueField:'id',
			displayField:'name',
			store:new GO.data.JsonStore({
				url: GO.url('addressbook/template/store'),
				baseParams: {'type':0},
				root: 'results',
				id: 'id',
				fields: ['id','name'],
				remoteSort: true
			}),
			mode:'remote',
			triggerAction:'all',
			editable:false,
			selectOnFocus:true,
			forceSelection:true,
			emptyText:GO.projects2.lang.emailTemplate,
			flex: 2
		});
		
		this.contractNotificationComp  = new Ext.form.CompositeField({
			fieldLabel : GO.projects2.lang.notification,
			items : [
				this.notificationDays,
				{xtype: 'plainfield', value: GO.lang.strDays},
				this.notificationActive,
				this.selectnotificationTemplate
			],
			hidden: true,
			anchor: '100%'
		});

		this.emptyLine = new GO.form.PlainField({
			value: '&nbsp;'
		});

		this.totalAmount = new Ext.form.Hidden({
			name: 'income.amount',
			anchor: '100%',
			fieldLabel: GO.projects2.lang['amount']
		});
		
		this.totalAmountLabel = new GO.form.PlainField({
			name: 'income.amountTotal',
			fieldLabel:GO.projects2.lang.total+' '+GO.projects2.lang.amount,
			labelStyle: 'font-weight:bold;',
			style: 'font-weight:bold;'
		});

		this.incomeLineStore = new Ext.data.ArrayStore({
			fields: ['description','amount','id','income_id'],
			data : [
			]
		});

		this.incomeLineGrid = new Ext.grid.EditorGridPanel({
			height: 200,
			store: this.incomeLineStore,
			tbar:[{
				iconCls: 'btn-add',
				text: GO.lang['cmdAdd'],
				cls: 'x-btn-text-icon',
				handler: function(){
					var r = new Ext.data.Record({
						id:null,
						income_id:this.remoteModelId,
						description: '',
						amount:0
					});
					this.incomeLineGrid.stopEditing();
					this.incomeLineStore.insert(0, r);
					this.incomeLineGrid.startEditing(0, 0);
				},
				scope: this
			},{
				iconCls: 'btn-delete',
				text: GO.lang['cmdDelete'],
				cls: 'x-btn-text-icon',
				handler: function(){
					var sel = this.incomeLineGrid.selModel.getSelectedCell();
					if(sel){
						// sel now contains an array of [row, col]
						this.incomeLineStore.removeAt(sel[0]);
						this.updateTotalAmount();
					}
				},
				scope: this
			}],
			columns: [
				{
					header: GO.lang.strDescription,
					dataIndex: 'description',
					editor: new Ext.form.TextArea()
				},{
					header: GO.projects2.lang.amount,
					dataIndex: 'amount',
					width: 30,
					align:'right',
					editor: new GO.form.NumberField({
						value : "0", 
						decimals:2
					})
				}
			],
			listeners:{
				afteredit:function(){
					this.updateTotalAmount();
				},
				scope:this
			},
			view: new Ext.grid.GridView({
				autoFill: true,
				forceFit: true,
				emptyText: GO.lang['strNoItems']
			}),
			loadMask: true,
			clicksToEdit: 1
		});
		
		this.itemsFieldset = new Ext.form.FieldSet({
			title: GO.lang.items,
			collapsed: false,
			collapsible: true,
			style: {
				marginTop: '0px'
			},
			defaults: {
				border: false,
				anchor:'100%'
			},
			items:[
				this.incomeLineGrid,
				this.totalAmount,
				this.totalAmountLabel
			]
		});
		
		this.propertiesPanel = new Ext.Panel({
			title:GO.lang['strProperties'],
			cls:'go-form-panel',
			layout:'form',
			autoScroll: true,
			items:[
			this.projectButton = new Ext.Button({
				text: GO.projects2.lang['showProject'],
				handler: function() {
					GO.projects2.showProjectDialog({
						project_id: this._projectId
					})
				},
				scope: this
			}),
			this.projectPathField,
			this.isContractCheck,
			this.repeatComp,
			this.contractEndDate,
			this.notificationText,
			this.contractNotificationComp,
			this.emptyLine,
			{				
				xtype: 'textfield',
				name: 'income.description',
				anchor: '100%',
				maxLength: 250,
				fieldLabel: GO.lang.strDescription
			},
			{				
				xtype: 'datefield',
				name: 'income.invoice_at',
				anchor: '100%',
				maxLength: 50,
				allowBlank:false,
				fieldLabel: GO.projects2.lang['invoiceAt'],
				value: new Date()
				}, {
					xtype: 'datefield',
					name: 'income.paid_at',
					anchor: '100%',
					maxLength: 50,
					allowBlank: true,
					fieldLabel: GO.projects2.lang['paidAt']
				}, 
				this.isInvoicedCheckbox = new Ext.ux.form.XCheckbox({
					xtype: 'xcheckbox',
					name: 'income.is_invoiced',
					disabled: true,
					fieldLabel: GO.projects2.lang['invoiced']
				}),{				
				xtype: 'xcheckbox',
				name: 'income.invoiceable',
				fieldLabel: GO.projects2.lang['invoiceable']
			},this.txtInvoiceNo = new Ext.form.TextField({				
				name: 'income.invoice_number',
				maxLength: 50,
//				hidden: this.isNew(),
				fieldLabel: GO.projects2.lang['invoiceNo']
			}),this.referenceNoField = new Ext.form.TextField({				
				name: 'income.reference_no',
				maxLength: 64,
				fieldLabel: GO.projects2.lang['referenceNo']
			}),
			this.commentsField = new Ext.form.TextArea({				
				name: 'income.comments',
				height: 100,
				anchor: '100%',
				fieldLabel: GO.lang['strComment']
			}),
			this.itemsFieldset,
			{
				xtype: 'plainfield',
				value: '<br /><strong>'+GO.projects2.lang['customerAddress']+':</strong>',
				hideLabel: true
			},{				
				xtype: 'textfield',
				name: 'income.contact',
				anchor: '100%',
				maxLength: 190,
				fieldLabel: GO.projects2.lang.contact
			},
			this.customerAddressField = new GO.form.PlainField({
				name: 'customer.formatted_address',
				hideLabel: true
			})
			]
		});

		this.addPanel(this.propertiesPanel);
	},
	
	updateTotalAmount : function() {
		
		var total = 0;
		
		this.incomeLineStore.each(function(record){
			total += GO.util.unlocalizeNumber(record.data.amount);
		},this);
		
		this.totalAmount.setValue(GO.util.numberFormat(total));
		this.totalAmountLabel.setValue(GO.util.numberFormat(total));
	},
//
	beforeSubmit : function(params){
		if(this.formPanel.getForm().getValues()['income.invoiceable']== "0") {
			this.formPanel.getForm().getValues()['income.is_invoiced'] = false;
			this.isInvoicedCheckbox.setValue('0');
		}
	
		// Save items from this.incomeLineStore
		params.incomeItems = [];
		this.incomeLineStore.each(function(record){
			params.incomeItems.push(record.data);
		},this);

		GO.projects2.IncomeDialog.superclass.beforeSubmit.call(this, params);
	},
	
	
	afterSubmit : function(action) {
			this.isInvoicedCheckbox.setDisabled(this.formPanel.getForm().getValues()['income.invoiceable']== "0");
			this.populateIncomeItems(action.result.incomeItems);
			GO.projects2.IncomeDialog.superclass.afterSubmit.call(this, action);
	},
	
	afterLoad : function(remoteModelId, config, action){
		this.populateIncomeItems(action.result.incomeItems);
	},
	
	populateIncomeItems : function(items){
		this.incomeLineStore.removeAll();
		for(var i=0; i < items.length; i++){
			
			var r = new Ext.data.Record({
				id:items[i].id,
				income_id:items[i].income_id,
				description: items[i].description,
				amount:items[i].amount
			});
			this.incomeLineGrid.stopEditing();
			this.incomeLineStore.insert(0, r);
		}
		
		this.updateTotalAmount();
	},
	
	afterShowAndLoad : function (remoteModelId, config, result){
		this.isInvoicedCheckbox.setDisabled(!result.data.income.attributes.invoiceable);
		this.toggleContractFields(result.data.income.attributes.is_contract);
	},
	
	show : function (remoteModelId, config) {
//		this.txtInvoiceNo.setVisible(!!remoteModelId);
		
		GO.projects2.IncomeDialog.superclass.show.call(this,remoteModelId, config);

		this.formPanel.baseParams['income.project_id'] = this._projectId = config.project_id;
//		this.projectId.setValue(config.project_id);
		this.projectButton.setVisible(this._projectId>0);
	},
	changeRepeat : function(value) {

		var repeatForever = this.repeatForever.getValue();
		
		var form = this.formPanel.form;
		switch (value) {
			default :
				this.disableDays(true);
				this.monthTime.setDisabled(true);
				this.repeatForever.setDisabled(true);
				this.repeatEndDate.setDisabled(true);
				this.repeatEvery.setDisabled(true);
				break;

			case 'DAILY' :
				this.disableDays(true);
				this.monthTime.setDisabled(true);
				this.repeatForever.setDisabled(false);
				this.repeatEndDate.setDisabled(repeatForever);
				this.repeatEvery.setDisabled(false);

				break;

			case 'WEEKLY' :
				this.disableDays(false);
				this.monthTime.setDisabled(true);
				this.repeatForever.setDisabled(false);
				this.repeatEndDate.setDisabled(repeatForever);
				this.repeatEvery.setDisabled(false);

				break;

			case 'MONTHLY_DATE' :
				this.disableDays(true);
				this.monthTime.setDisabled(true);
				this.repeatForever.setDisabled(false);
				this.repeatEndDate.setDisabled(repeatForever);
				this.repeatEvery.setDisabled(false);

				break;

			case 'MONTHLY' :
				this.disableDays(false);
				this.monthTime.setDisabled(false);
				this.repeatForever.setDisabled(false);
				this.repeatEndDate.setDisabled(repeatForever);
				this.repeatEvery.setDisabled(false);
				break;

			case 'YEARLY' :
				this.disableDays(true);
				this.monthTime.setDisabled(true);
				this.repeatForever.setDisabled(false);
				this.repeatEndDate.setDisabled(repeatForever);
				this.repeatEvery.setDisabled(false);
				break;
		}
	},
});