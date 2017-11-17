 Ext.onReady(function(){
   Ext.QuickTips.init();
Ext.BLANK_IMAGE_URL ='ext-3.2.1/resources/images/default/s.gif';
/////////////////////////////////////////////
var Config = {
blank_image_url: 'ext-3.2.1/resources/images/default/s.gif',
load_mask: 'loading data. Please be patient...',
grid_no_data: '<br/><br/><center><div class="no_data">No data available...</div></center>'
};
///////////////////////////////////////////////////////////
function rashfunadduserlogin(){
var winadduserlogin1=Ext.getCmp('adduserloginwin');
if(!winadduserlogin1)
{
var formadduserlogin = new Ext.FormPanel({
            id:'formadduserlogin',
            name:'formadduserlogin',
             url:'adduserloginemail.php',
 frame:true,
        bodyStyle:'padding:10px',
             border:false,
            
  items: [{
            layout:'column',
          labelWidth:110,
            border:false,
            items:[{
                columnWidth:.99,
                layout: 'form',
                border:false,
                items: [{
                    xtype:'textfield',
                    fieldLabel: 'User Name',
                    id: 'addloginusername',
                    name: 'addloginusername',
                    allowBlank:false,
 msgTarget:'side', validationEvent:false,
// style:'background-color:#EFFFF9; background-image: none;',
                        width:220
                 //   anchor:'95%'
                }
     ]
}]
},
{
layout:'column',
   border:false,
            items:[{
               columnWidth:.99,
                columnHight:.30,
                layout: 'form',
                  border:false,
                labelWidth: 110,
 items: [{
 xtype:'textfield',
                    fieldLabel: 'Display Name',
                    id: 'adduserlogindisplayname',
                    name: 'adduserlogindisplayname',
// style:'background-color:#EFFFF9; background-image: none;',
                        width:220
                 //   anchor:'95%'
                }
     ]
}]
},
{
layout:'column',
   border:false,
            items:[{
               columnWidth:.99,
                columnHight:.30,
                layout: 'form',
                  border:false,
                labelWidth: 110,
 items: [{
 xtype:'textfield',
                    fieldLabel: 'Email',
                    id: 'adduserloginemail',
                    name: 'adduserloginemail',
                   vtype:'email',
              allowBlank:false,
// style:'background-color:#EFFFF9; background-image: none;',
                        width:220
                 //   anchor:'95%'
                }
     ]
}]



},
{
layout:'column',
   border:false,
            items:[{
               columnWidth:.99,
                columnHight:.30,
                layout: 'form',
                  border:false,
                labelWidth: 110,
 items: [{
 xtype:'textfield',
        fieldLabel: 'Org Unit',
        id:'addorgunit',
        name: 'addorgunit',
// style:'background-color:#FFFEE9; background-image: none;',
        readOnly:false,
           width: 220
      }
 ]
}]

}]

});

////////////////////////////
var winadduserlogin= new Ext.Window({
        id:'adduserloginwin',
         name:'adduserloginwin',
        title: '<b><font color=green>Add User</font>',
          closable:true,
                            hideBorders: true,
                            bodyBorder: false,
     autoScroll: false,
        width: 450,
        height:250,
        minSize: 300,
        maxSize: 200,
           buttonAlign:'center',
        iconCls:'icon-group-add',
        layout: 'fit',
         draggable:true,
    frame:true,
 listeners: {
                            maximize: function() {

                                 winadduserlogin.maximize();
}
},

              resizable:true,
        plain:true,
     maximizable:true,
 onEsc: Ext.emptyFn,
 viewConfig:{maximizable:true},
defaults:{maximizable:true},
  buttons: [{
buttonAlign:'center',
           text:'<b>Save</b>',id:'adduserloginsave',name:'adduserloginsave',
iconCls:'icon-disk',
   handler: function() {
                    var forma = formadduserlogin.getForm();
// var blgroupname =Ext.getCmp('addloginusername').getValue();
                 //   var blgrdes =Ext.getCmp('bulkfromaddress').getValue();
  //         var bunadds =Ext.getCmp('adduserloginemail').getValue();
    //   if(blgroupname === "")
//{
//alert("dfdf");
//Ext.MessageBox.alert('Can\'t Add User','<font color=red><b>Please enter user name.</b></font>');
//}
/* else if(blgrdes === "")
{
Ext.MessageBox.alert('Can\'t Create Group','<font color=red><b>Please enter valid from address.</b></font>');
} */
//else if(bunadds === "")
//{
//Ext.MessageBox.alert('Can\'t Add User','<font color=red><b>Please enter valid email address.</b></font>');
//}

                    if (forma.isValid()) {
    forma.submit({
                        waitMsg: 'Saving...',
//success: function(formgroup, action) {Ext.Msg.alert('Status',action.result.success.message)},
success: function(formadduserlogin, action) {Ext.Msg.alert('Add User', 'User added successfully!', function(btn, text){
                                   if (btn == 'ok'){
 winadduserlogin.close();
//dsmanage.load({params:{start: 0, limit: 100}});
                                   }
                                });
},
 failure: function(formadduserlogin, action) {Ext.Msg.alert('<font color=red>'+'Sorry,Can not add user '+'</font>',action.result.failure.message)},
                            scope: this
                        });
                    }
                },
                scope: this
}],
 items:formadduserlogin
           });
winadduserlogin.show();
} else {
winadduserlogin1.hide();
}

if(winadduserlogin1)
{
winadduserlogin1.show();
}


}
///////////////////////////////
var userloginemaildatastore= new Ext.data.JsonStore({
 url: 'userloginemailgrid.php',
 root: 'data.resultsul',
              autoShow : true,
        totalProperty: 'data.totalul',
    fields: [

     {name: 'displayname',mapping: 'displayname',type: 'string'},
{name:'username',mapping: 'username',type: 'string'},
{name:'email',mapping:'email',type: 'string'},
{name:'orgunit',mapping:'orgunit',type: 'string'}
],
 sortInfo:{field: 'username', direction: 'ASC'},
          remoteSort:true

});

var userloginemailcolumnmodel=new Ext.grid.ColumnModel([
{
 header: "User Name",
dataIndex: 'username',
 sortable:true,
                width: 40

},
{
 header: "Display Name",
dataIndex: 'displayname',
 sortable:true,
                width: 40,
 editor: {
                xtype: 'textfield'
            }


},
{
 header: "Email",
dataIndex: 'email',
 sortable:true,
                width: 130,
editor: {
                xtype: 'textfield',
                allowBlank: false,
                vtype: 'email'
            }


},
{
 header: "Org Unit",
dataIndex: 'orgunit',
 sortable:true,
                width: 130,
 editor: {
                xtype: 'textfield'
            }

}
]);
 var editor = new Ext.ux.grid.RowEditor({
        saveText: 'Update'
    });


var griduserloginemail= new Ext.grid.GridPanel({
id:'griduserloginemail',
      ds: userloginemaildatastore,
      cm: userloginemailcolumnmodel,
         region:'center',
       // height:310,
//plugins:[emailogsearchfilters],
plugins: [editor],

      enableColLock:false,
   frame:true,
        autoScroll:true,
 loadMask: { msg: Config.load_mask, store: userloginemaildatastore },
    viewConfig: { emptyText: Config.grid_no_data,
forceFit: true
},


      sm: new Ext.grid.RowSelectionModel({
                        singleSelect: true
                    }),

      bbar: new Ext.PagingToolbar({
            //    plugins:[emailogsearchfilters,new Ext.ux.Andrie.pPageSize()],
                store: userloginemaildatastore, 
             pageSize: 100,
displayInfo: true,
  emptyMsg: "No records to display"

})
});

/////////////////////////////////////////////////////////////////
var winuserloginemail = new Ext.Window({
        id:'winuserloginemail',
        name:'winuserloginemail',
        title: '<b>User Login Email Map</b>',
        closable:false,
   constrain:true,
        iconCls:'icon-info',
        layout: 'border',
           onEsc: Ext.emptyFn,
        plain:true,
listeners: {
 show: function() {

                                winuserloginemail.maximize();
}

},

        minimizable:false,
        border:true,
        frame:true,
        resizable:true,
items:[griduserloginemail],
tbar:[{
text:'<b>Add User</b>',
id:'adduserras',
name:'adduserras',
handler:function(){rashfunadduserlogin();
}

}]

  });
userloginemaildatastore.load({params:{start: 0, limit: 100}});
winuserloginemail.show();
///////////////////////////////////////
});
