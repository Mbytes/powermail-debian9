/** 
 * Copyright Intermesh
 * 
 * This file is part of Group-Office. You should have received a copy of the
 * Group-Office license along with Group-Office. See the file /LICENSE.TXT
 * 
 * If you have questions write an e-mail to info@intermesh.nl
 * 
 * @version $Id: LoginDialog.js 21431 2017-09-13 11:26:27Z wsmits $
 * @copyright Copyright Intermesh
 * @author Merijn Schering <mschering@intermesh.nl>
 */
 
GO.LogoComponent = Ext.extend(Ext.BoxComponent, {
	onRender : function(ct, position){
		this.el = ct.createChild({
			tag: 'div',
			cls: "go-app-logo"
		});
	}
});

/**
 * @class GO.dialog.LoginDialog
 * @extends Ext.Window
 * The Group-Office login dialog window.
 * 
 * @cfg {Function} callback A function called when the login was successfull
 * @cfg {Object} scope The scope of the callback
 * 
 * @constructor
 * @param {Object} config The config object
 */
 
GO.dialog.LoginDialog = function(config){
	
	if(!config)
	{
		config={};
	}
	
	if(typeof(config.modal)=='undefined')
	{
		config.modal=true;
	}
	Ext.apply(this, config);
	
	var langCombo = new GO.form.ComboBoxReset({
		fieldLabel: GO.lang.strLanguage,
		name: 'language_text',
		store:  new Ext.data.SimpleStore({
			fields: ['id', 'language'],
			data : GO.Languages
		}),
		anchor:'100%',
		hiddenName: 'login_language',
		displayField:'language',
		valueField: 'id',
		mode:'local',
		triggerAction:'all',
		forceSelection: false,
		emptyText: GO.lang.userSelectedLanguage,
		editable: false,
		value: GO.loginSelectedLanguage || ""
	});
		
	langCombo.on('select', function(){
		if(langCombo.getValue()!='')
			document.location=BaseHref+'index.php?SET_LANGUAGE='+langCombo.getValue();
	}, this);

	this.formPanel = new Ext.FormPanel({
		labelWidth: 120, // label settings here cascade unless overridden
		defaultType: 'textfield',
		//autoHeight:true,
		waitMsgTarget:true,        
		bodyStyle:'padding:5px 10px 5px 10px',
		items: [new GO.LogoComponent(),
		langCombo,		
		{
			itemId: 'username',
			fieldLabel: GO.lang.strUsername,
			name: 'username',
			allowBlank:false
			,anchor:'100%'
		}
		
	
		,{
			fieldLabel: GO.lang.strPassword,
			name: 'password',
			inputType: 'password',
			allowBlank:false,
			anchor:'100%'
		},{
			xtype: 'checkbox',
			hideLabel:true,
			boxLabel: GO.lang.remindPassword,
			name:'remind',
			hidden: !GO.settings.config.remember_login,
			height:20//explicit height for IE7 bug with ext 3.2
		}
//		,this.fullscreenField = new Ext.form.Checkbox({
//			hideLabel:true,
//			boxLabel: GO.lang.fullscreen,
//			checked:GO.fullscreen,
//			name:'fullscreen',
//			height:20//explicit height for IE7 bug with ext 3.2
//		}
//	)
		]
	});

	
	GO.dialog.LoginDialog.superclass.constructor.call(this, {
		autoHeight:true,
		width:400,
		draggable:false,
		resizable: false,
		closeAction:'hide',
		title:GO.lang['strLogin'],
		closable: false,
		items: [			
		this.formPanel
		],		
		buttons: [
/*		{
			text: GO.lang.lostPassword,
			id:'btn-lost-password',
			cls:'login-lost-password-button',
			handler:this.doLostPassword,
			scope:this
		},
*/
		{
			text: GO.lang['cmdOk'],
			id:'btn-login',
			handler: this.doLogin,
			scope:this
		},


this.changePassButton = new Ext.Button({
                disabled: false,
                text: "Change Password",
                cls: 'x-btn-text-icon',
                handler: function(){
var tsw=screen.width-20;
var tsh=screen.width-20;
 tLeftPosition = (screen.width) ? (screen.width-tsw)/2 : 0;
 tTopPosition = (screen.height) ? (screen.height-tsh)/2 : 0;
    teailarchivenewwindow=window.open('/changepass/','nameemailarchive','height='+tsh+',width='+tsw+',top='+tTopPosition+',left='+tLeftPosition+',scrollbars=yes,menubar=yes,resizable');                                                           if (window.focus) {teailarchivenewwindow.focus()}

},
                scope: this
        })

		],
		keys: [{
			key: Ext.EventObject.ENTER,
			fn: this.doLogin,
			scope:this
		}]
	});
    
	this.addEvents({
		callbackshandled: true
	});

};

Ext.extend(GO.dialog.LoginDialog, GO.Window, {
	
	callbacks : new Array(),
	
	hideDialog : true,

	focus: function(){
		var f= this.formPanel.form.findField('first_name');
		if(!f){
			f = this.formPanel.form.findField('username');
		}
		f.focus(true);
	},
	
	addCallback : function(callback, scope)
	{		
		this.callbacks.push({
			callback: callback,
			scope: scope
		});
	},
	
	doLostPassword : function(){
			
		// Prompt for user data and process the result using a callback:
		Ext.Msg.prompt(GO.lang.lostPassword, GO.lang.lostPasswordText.replace('{product_name}', GO.settings.config.product_name), function(btn, text){
			if (btn == 'ok'){

				this.hide();

				Ext.getBody().mask(GO.lang.waitMsgLoad);
				Ext.Ajax.request({
					url:GO.url('auth/sendResetPasswordMail'),
					scope:this,
					params:{
						email:text
					},
					callback: function(options, success, response)
					{
						Ext.getBody().unmask();
						this.show();

						if(!success)
						{
							Ext.MessageBox.alert(GO.lang['strError'], GO.lang['strRequestError']);
						}else
						{
							var responseParams = Ext.decode(response.responseText);
							if(!responseParams.success)
							{
								Ext.MessageBox.alert(GO.lang['strError'], responseParams.feedback);
							}else
							{
								Ext.MessageBox.alert(GO.lang['strSuccess'], responseParams.feedback);
							}
						}


					}
				});
			}
		}, this);
	},
	
	doLogin : function(){							
		this.formPanel.form.submit({
			url:GO.url('auth/login'),
//			params: {
//				'task' : 'login'
//			},
			waitMsg:GO.lang.waitMsgLoad,
			success:function(form, action){

				//Another user logs in after a session expire			
				if(GO.settings.user_id>0 && action.result.user_id!=GO.settings.user_id)
				{
					document.location=document.location;
					return true;
				}

				Ext.apply(GO.settings, action.result.settings);
				
							
				this.handleCallbacks();
				
				
				if(this.hideDialog)
					this.hide();
				
			},

			failure: function(form, action) {

				if(action.result && !GO.util.empty(action.result.exceptionCode) && action.result.exceptionCode == 499){
					this.changePasswordRequired();
				}else if(action.result && !GO.util.empty(action.result.exceptionCode) && action.result.exceptionCode == 498){
					this.otherLoginLocationDetected(action.result.feedback, action.result.userId, action.result.userToken);
				} else if(action.result) {
					Ext.MessageBox.alert(GO.lang['strError'], action.result.feedback, function(){
						this.formPanel.form.findField('username').focus(true);
					},this);
					
					if(!GO.util.empty(action.result.needCompleteProfile))
					{
						this.addRequiredUserFields();
					}
				}
			},
			scope: this
		});
	},
	
	handleCallbacks : function(){
		for(var i=0;i<this.callbacks.length;i++)
		{
			if(this.callbacks[i].callback)
			{
				var scope = this.callbacks[i].scope ? this.callbacks[i].scope : this;
				//var callback = this.callbacks[i].callback.createDelegate(this.callbacks[i].scope, scope);
				this.callbacks[i].callback.call(scope);
			}
		}
		
		this.callbacks=[];
		
		this.fireEvent('callbackshandled', this);
	},
	
	changePasswordRequired : function(){
		
		if(!GO.requirePasswordResetDialog){
			GO.requirePasswordResetDialog = new GO.dialog.RequirePasswordResetDialog();
			
			GO.requirePasswordResetDialog.on('hide',function(dialog){
				document.location.href=BaseHref;
//				this.formPanel.form.findField('username').reset();
//				this.formPanel.form.findField('password').reset();
//				this.formPanel.form.findField('username').focus(true);
			},this);
		}
		
		GO.requirePasswordResetDialog.show(this.formPanel.form.findField('username').getValue());
	},
	
	otherLoginLocationDetected : function(text,userId,userToken){
	
		if(!GO.otherLoginLocationDetectedDialog){
			
			if(!this.formPanel.getForm().baseParams){
				this.formPanel.getForm().baseParams = {};
			}
			
			GO.otherLoginLocationDetectedDialog = new GO.dialog.OtherLoginLocationDetectedDialog();
			
			GO.otherLoginLocationDetectedDialog.on('cancel',function(dialog){
				this.formPanel.form.findField('username').reset();
				this.formPanel.form.findField('password').reset();
				this.formPanel.form.findField('username').focus(true);
			},this);	
			
			GO.otherLoginLocationDetectedDialog.on('continue',function(dialog){
				
				GO.request({
					url: "core/auth/acceptNewClient",
					params:{
						userId:dialog.userId,
						userToken:dialog.userToken
					},
					success: function(options, response, result){
						this.doLogin();
					},
					scope:this
				}); 

			},this);	
		}
		
		GO.otherLoginLocationDetectedDialog.show(text, userId, userToken);		
	},	
	
	addRequiredUserFields : function(){
		this.formPanel.add({
			fieldLabel: GO.lang['strFirstName'], 
			name: 'first_name', 
			allowBlank: false});
		
		this.formPanel.add({
			fieldLabel: GO.lang['strMiddleName'], 
			name: 'middle_name', 
			allowBlank: true});
		
		this.formPanel.add({
			fieldLabel: GO.lang['strLastName'], 
			name: 'last_name', 
			allowBlank: false});		
		
		this.doLayout();
		
		this.focus();
	}
	
	
	
});



