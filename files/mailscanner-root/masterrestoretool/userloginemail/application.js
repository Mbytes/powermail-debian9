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
             url:'adduserloginemail.cgi',
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
               columnWidth:.6,
                columnHight:.30,
                layout: 'form',
                  border:false,
                labelWidth: 110,
 items: [{
 xtype:'textfield',
                    fieldLabel: 'Email',
                    id: 'adduserloginemail',
                    name: 'adduserloginemail',
               //    vtype:'email',
              allowBlank:false,
// style:'background-color:#EFFFF9; background-image: none;',
                        width:120
                 //   anchor:'95%'
                }
     ]

  },{
                columnWidth:.4,
                layout: 'form',
                labelWidth: 70,
            items:[{
    //    html:'<b> @motilaloswal.com </b>'
   xtype:'textfield',
fieldLabel: '<b> @motilaloswal.com </b>',
 labelSeparator:'',
hidden:true
      }]


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
 onEsc: Ext.emptyFn,
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
userloginemaildatastore.load({params:{start: 0, limit: 100}});
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
 url: 'userloginemailgrid.cgi',
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

var filtersuserloginemail = new Ext.ux.grid.GridFilters({
 remote:true,
      filters:[

{dataIndex: 'username',type: 'string'},

{dataIndex: 'displayname',type: 'string'},
{dataIndex: 'email',type: 'string'},

{dataIndex: 'orgunit',type: 'string'}
]
});

var smblacklist = new Ext.grid.CheckboxSelectionModel();
var userloginemailcolumnmodel=new Ext.grid.ColumnModel([
smblacklist,
/*{
header: 'Edit Users',
        dataIndex: 'memfun',
        width: 130,
        sortable:false,
 renderer: function mn (value,cell,record,rowIndex, columnIndex, store) {
cell.css="colorcell";
return '<div class="controlBtnblm"> <img src="img/user_edit.png" width="16" height="16" > <span class="control_editblm">Users</span></div>';
}


},*/
{
 header: "User Name",
dataIndex: 'username',
 sortable:true,
                width: 100,

renderer: function (value, metadata, record, cell, rowIndex, columnIndex, store) {
 var title = 'Click for Edit User &nbsp;-' + record.get('username');
    var tip = record.get('email');

    metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + tip + '"';
//        qtip = " qtip='Click for details ' />";
        return '<b><span style="color:blue;">' +  value + '</span></b>';

//  return value;
}

},
{
 header: "Display Name",
dataIndex: 'displayname',
 sortable:true,
                width: 100

},
{
 header: "Email",
dataIndex: 'email',
 sortable:true,
                width: 160

},
{
 header: "Org Unit",
dataIndex: 'orgunit',
 sortable:true,
                width: 140
}
]);
//////////////////////////
function  deleteselusers(btn){
if(btn=='yes'){
       var selections = griduserloginemail.selModel.getSelections();
       var tt=griduserloginemail.selModel.getCount();
         var prezmail = [];
         for(i = 0; i< griduserloginemail.selModel.getCount(); i++){
        prezmail.push(selections[i].json.username);
    //       completedata = prez.push(selections[i].msgfilename);
         }

//alert(prezmail);

   var encoded_array = Ext.encode(prezmail);
         var urlm = 'deleteselectedusers.cgi';
    //   alert(prezmail);
         Ext.Ajax.request({
            waitMsg: 'Please Wait',
            url: urlm,

            params: {
           //  task: "DELETEPRES",
               task: encoded_array
           },
 callback: function (options, success, response) {
                            if (success) {
                                Ext.MessageBox.alert('OK',response.responseText);
                                var json = Ext.util.JSON.decode(response.responseText);
                                tt = response.responseText;
                                Ext.MessageBox.alert('OK', '<b><font color=red>'+tt+'</font>  record(s) get deleted.</b>');
                            } else {
                                Ext.MessageBox.alert('Sorry, please try again. [Q304]',response.responseText);
                            }
                        },
failure:function(response,options){
 Ext.MessageBox.alert('Warning','Oops...');
                            //ds.rejectChanges();//undo any changes
                        },
                        success:function(response,options){
                            //Ext.MessageBox.alert('Success','Yeah...');
                            userloginemaildatastore.reload();//commit changes and remove the red triangle which indicates a 'dirty' field
                        }

         });
    


}

}
/////////////////////
var griduserloginemail= new Ext.grid.GridPanel({
id:'griduserloginemail',
      ds: userloginemaildatastore,
      cm: userloginemailcolumnmodel,
         region:'center',
       // height:310,
plugins:[filtersuserloginemail],
      enableColLock:false,
   frame:true,
        autoScroll:true,
 loadMask: { msg: Config.load_mask, store: userloginemaildatastore },
    viewConfig: { emptyText: Config.grid_no_data,
forceFit: true
},


 sm:smblacklist,
      bbar: new Ext.PagingToolbar({
            //    plugins:[emailogsearchfilters,new Ext.ux.Andrie.pPageSize()],
                store: userloginemaildatastore, 
             pageSize: 100,
displayInfo: true,
  emptyMsg: "No records to display",

items:[{xtype:'tbspacer'},{xtype:'tbspacer'},{xtype:'tbspacer'},{xtype:'tbspacer'},
{xtype: 'tbbutton', id:'downloadbutton1',text:'<b>Delete Selected Users</b>',
 tooltip: 'Delete selected users...',
          iconCls:'icon-minus',
handler: function confirmDeletebl(){
if(griduserloginemail.selModel.getCount() === 1) // only one president is selected here
    {
      Ext.MessageBox.confirm('Confirmation','<b>Do you really want to delete this selection. Continue?</b>', deleteselusers);
    } else if(griduserloginemail.selModel.getCount() > 1){
      Ext.MessageBox.confirm('Confirmation','<b>Do you really want to delete all those selections?</b>', deleteselusers);
    } else {
      Ext.MessageBox.alert('Message','<b>Please select at least one record to delete</b>');
    }

}

}]

})
});
//////////////////////////////
/*iduserloginemail.on('click', function(e) {
        var btn1 = e.getTarget('.controlBtnblm');
        if (btn1) {
            var t = e.getTarget();
            var v = griduserloginemail.getView();
            var rowIdx = v.findRowIndex(t);
       //   var record = gridmanage.getStore().getAt(rowIdx);
                 var record1 = griduserloginemail.getStore().getAt(rowIdx);
           var usernameadds =record1.get('username');
            var control1 = t.className.split('_')[1];
          switch (control1) {
                case 'editblm':
*/
griduserloginemail.addListener({
'cellclick':{
                fn: function(grid, rowIndex, columnIndex, event){

var record = griduserloginemail.getStore().getAt(rowIndex);  // Get the Record
 var fieldName = griduserloginemail.getColumnModel().getDataIndex(columnIndex); // Get field name
           var emaildata = record.get(fieldName);
              var usernameadds = record.get('username');
// DATA is id nere
if(fieldName=='username'){
//alert(usernameadds);
//alert(memide);
rashfunedituser(usernameadds);
var resultxe="";
var errorxe="Some of the form(s) are not added to database.please enter the records.";
var urlxae='edituserclick.cgi?usernameadds='+usernameadds;
//alert(urlxae);
//Ext.getCmp('smsmembernameedit').setValue(memberdata);
Ext.Ajax.request({
        url : urlxae ,
success: function ( result, request ) {
resultxe=result.responseText;
//alert(resultx);
var ggge=resultxe.split(',');
if(resultxe=="ERR1")
{
Ext.MessageBox.show({
       title: 'Data Selection Error', msg: errorxe
       });
}
{
var f4=resultxe;
//Ext.getCmp('editloginusername').setValue(usernameadds);
//Ext.getCmp('editloginusername').setReadOnly(true);
Ext.getCmp('edituserlogindisplayname').setValue(ggge[0]);

var gscolone=ggge[1].split("@");
Ext.getCmp('edituserloginemail').setValue(gscolone[0]);
Ext.getCmp('editorgunit').setValue(ggge[2]);
}
}
});
/////////////////////////////////
}
                }
                ,scope:this
}
});

/////////////////////////////////////////
function rashfunedituser(usernameadds){
var winedituserlogin1=Ext.getCmp('edituserloginwin');
if(!winedituserlogin1)
{
var formedituserlogin = new Ext.FormPanel({
            id:'formedituserlogin',
            name:'formedituserlogin',
             url:'edituserloginemail.cgi?usernameadds='+usernameadds,
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
 labelWidth: 110,
        /*        items: [{
                    xtype:'textfield',
                    fieldLabel: 'User Name',
                    id: 'editloginusername',
                    name: 'editloginusername',
                     editable:false,
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
                labelWidth: 110,*/
 items: [{
 xtype:'textfield',
                    fieldLabel: 'Display Name',
                    id: 'edituserlogindisplayname',
                    name: 'edituserlogindisplayname',
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
               columnWidth:.6,
                columnHight:.30,
                layout: 'form',
                  border:false,
                labelWidth: 110,
 items: [{
 xtype:'textfield',
                    fieldLabel: 'Email',
                    id: 'edituserloginemail',
                    name: 'edituserloginemail',
             //      vtype:'email',
              allowBlank:false,
// style:'background-color:#EFFFF9; background-image: none;',
                        width:120
                 //   anchor:'95%'
                }
     ]
 },{
                columnWidth:.4,
                layout: 'form',
                labelWidth: 70,
            items:[{
    //    html:'<b> @motilaloswal.com </b>'
   xtype:'textfield',
fieldLabel: '<b> @motilaloswal.com </b>',
 labelSeparator:'',
hidden:true
      }]


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
        id:'editorgunit',
        name: 'editorgunit',
// style:'background-color:#FFFEE9; background-image: none;',
        readOnly:false,
           width: 220
      }
 ]
}]

}]

});

////////////////////////////
var winedituserlogin= new Ext.Window({
        id:'edituserloginwin',
         name:'edituserloginwin',
        title: '<b><font color=green>Edit User For :-</font>' + usernameadds+'</b>',
          closable:true,
                            hideBorders: true,
                            bodyBorder: false,
     autoScroll: false,
        width: 450,
        height:210,
        minSize: 300,
        maxSize: 200,
           buttonAlign:'center',
        iconCls:'icon-group-add',
        layout: 'fit',
         draggable:true,
    frame:true,
 listeners: {
                            maximize: function() {

                                 winedituserlogin.maximize();
}
},

              resizable:true,
        plain:true,
   //  maximizable:true,
 onEsc: Ext.emptyFn,
// viewConfig:{maximizable:true},
//defaults:{maximizable:true},
  buttons: [{
buttonAlign:'center',
           text:'<b>Update</b>',id:'edituserloginsave',name:'edituserloginsave',
iconCls:'icon-disk',
   handler: function() {
                    var forma = formedituserlogin.getForm();

                    if (forma.isValid()) {
    forma.submit({
                        waitMsg: 'Saving...',
//success: function(formgroup, action) {Ext.Msg.alert('Status',action.result.success.message)},
success: function(formedituserlogin, action) {Ext.Msg.alert('Edit User', 'User updated successfully!', function(btn, text){
                                   if (btn == 'ok'){
 winedituserlogin.close();
userloginemaildatastore.load({params:{start: 0, limit: 100}});
                                   }
                                });
},
 failure: function(formedituserlogin, action) {Ext.Msg.alert('<font color=red>'+'Sorry,Can not update user '+'</font>',action.result.failure.message)},
                            scope: this
                        });
                    }
                },
                scope: this
}],
 items:formedituserlogin
           });
winedituserlogin.show();
} else {
winedituserlogin1.hide();
}

if(winedituserlogin1)
{
winedituserlogin1.show();
}


}
///////////////////////////////

//////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
var winuserloginemail = new Ext.Window({
        id:'winuserloginemail',
        name:'winuserloginemail',
        title: '<b>User Login Email Map</b>',
        closable:false,
   constrain:true,
        iconCls:'icon-group-add',
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
iconCls:'icon-group-add',
handler:function(){rashfunadduserlogin();
}

}]

  });
userloginemaildatastore.load({params:{start: 0, limit: 100}});
winuserloginemail.show();
///////////////////////////////////////
});
