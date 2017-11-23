#!/usr/bin/perl

print "Content-type: text/html\n\n";

print <<"XYZXYZ";
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>QMail Queue Status</title>

    <link rel="stylesheet" type="text/css" href="ext-2.2/resources/css/ext-all.css"/>

 <link rel="stylesheet" type="text/css" href="icons.css">

          <link rel="stylesheet" type="text/css" href="ext-2.2/resources/css/ext-all.css" />
 	  <script type="text/javascript" src="ext-2.2/adapter/ext/ext-base.js"></script>
          <script type="text/javascript" src="ext-2.2/ext-all.js"></script>
<script type="text/javascript" src="grid-filtering/menu/EditableItem.js"></script>
<script type="text/javascript" src="grid-filtering/menu/RangeMenu.js"></script>
<script type="text/javascript" src="grid-filtering/grid/GridFiltersrash.js"></script>
<script type="text/javascript" src="grid-filtering/grid/filter/Filter.js"></script>
<script type="text/javascript" src="grid-filtering/grid/filter/StringFilter.js"></script>
<script type="text/javascript" src="grid-filtering/grid/filter/DateFilter.js"></script>
<script type="text/javascript" src="grid-filtering/grid/filter/ListFilter.js"></script>
<script type="text/javascript" src="grid-filtering/grid/filter/NumericFilter.js"></script>
<script type="text/javascript" src="grid-filtering/grid/filter/BooleanFilter.js"></script>

   <script type="text/javascript" src="ux.Andrie.pPageSize/pPageSize.js"></script> 
   <link rel="stylesheet" type="text/css" href="file-upload.css"/>
    <script type="text/javascript" src="FileUploadField.js"></script>

         
         <script type="text/javascript"> 
           Ext.onReady(function(){
           Ext.QuickTips.init();
   Ext.BLANK_IMAGE_URL ='ext-2.2/resources/images/default/s.gif';
/////////////////////////////////////////////
Ext.menu.RangeMenu.prototype.icons = {
          gt: 'ext-2.2/examples/grid-filtering/img/greater_then.png',
          lt: 'ext-2.2/examples/grid-filtering/img/less_then.png',
          eq: 'ext-2.2/examples/grid-filtering/img/equals.png'
                                };
        Ext.grid.filter.StringFilter.prototype.icon = 'ext-2.2/examples/grid-filtering/img/find.png';

///////////////////////////////////////////// 
           function subject(val){
                                 return '<span style="color:red;">' + val + '</span>';
                                }
//////////////////////////////////////////////////////////
           var dsmailstatus = new Ext.data.JsonStore({
           url:'maildsgrid.cgi',
           method: 'POST',
           totalProperty: 'data.total',
           root: 'data.results',
           fields: [
                    {name:'msgfilename'},
                    {name:'mailondate'},
                    {name:'from'},
                    {name:'to'},
                    {name:'subject'},
                    {name:'size'},
                    {name:'asondate'}
                  ],
            sortInfo: {field: 'subject', direction: 'ASC'},
            remoteSort:true
           });
             dsmailstatus.load();
 
          var filtermailstatus = new Ext.grid.GridFilters({
                 remote:true,
                 filters:[
                          {type: 'string', dataIndex: 'msgfilename'},
                          {type:'string', dataIndex: 'mailondate'},
                          {type: 'string', dataIndex: 'from'},
                          {type: 'string', dataIndex: 'to'},
                          {type: 'string', dataIndex: 'subject'},
                          {type: 'numeric', dataIndex: 'size'},
                          {type: 'string', dataIndex: 'asondate'}
            ]});
         var smmailstatus = new Ext.grid.CheckboxSelectionModel();
         var cmmailstatus = new Ext.grid.ColumnModel([
               smmailstatus,
                       {header: "File Name", width: 90, sortable: true,dataIndex:'msgfilename'},
                       {header: "Mail Dated", width: 120, sortable: true,dataIndex:'mailondate'},
                       {header: "From", width: 90, sortable: true,dataIndex:'from'},
                       {header: "To", width: 90, sortable: true,dataIndex:'to'},
                       {header: "Subject", width: 160, sortable: true,renderer:subject,dataIndex:'subject'},
                       {header: "Size", width: 50, sortable: true,dataIndex:'size'},
                       {header: "As On Date", width: 120, sortable: true,dataIndex:'asondate'}
            ]);
            cmmailstatus.defaultSortable = true;
          var gridmailstatus = new Ext.grid.GridPanel({
                     id: 'gridmailstatus',
                     ds:dsmailstatus,
                     cm:cmmailstatus,
                     sm:smmailstatus,
                     enableColLock: false,
                     loadMask: true,
                     plugins: filtermailstatus,
                     frame:true,
                     autoScroll:true,
                     viewConfig: {
                                  forceFit: true
                                 },
                     bbar: new Ext.PagingToolbar({
                                  plugins:[filtermailstatus,new Ext.ux.Andrie.pPageSize()],
                                  store:dsmailstatus,
                                  pageSize: 100,
                                  displayInfo: true,
                                  emptyMsg: "No queues to display"
                              }),
                     width:550, 
                     height:300
            });
            cmmailstatus.defaultSortable = true;
            dsmailstatus.load({params:{start: 0, limit: 100}});
            gridmailstatus.addListener({
                    'cellclick':{
                                   fn: function(grid, rowIndex, columnIndex, event){
                                   var record = gridmailstatus.getStore().getAt(rowIndex);  // Get the Record
                                var fieldName = gridmailstatus.getColumnModel().getDataIndex(columnIndex); // Get field name
                                   var subject = record.get(fieldName);
                     var msgfilename = record.get('msgfilename');
                                 if(fieldName=='subject')
                                               {
                                                     rashfunmailstatus(subject,msgfilename);
                                               }
                                      }
                     ,scope:this
                  }
           });
            function rashfunmailstatus(subject,msgfilename)
              {
                  var winmailstatusclick= new Ext.Window({
                          id:'mailstatusclickwin',
                          name:'mailstatusclickwin',
                          title: 'Showing Single Email Details',
                          closable:true,
                 width: 650,
                 height:350,
                 layout: 'fit',
                 plain:true,
                 maximizable:true,
                 minimizable:false,
                 border:true,
                 region:'center',
                 onEsc: Ext.emptyFn,
                            html:'<iframe src="view_mail.cgi?myemailfile=/var/qmail/queue/mess/'+msgfilename+'" height=420 width=732 scrolling="auto" frameborder="0" align="top">',
                  frame:true,
                 resizable:true
                     });
             winmailstatusclick.show();
           }
          function funreloadmailstatus()
           {
              Ext.getBody().mask('Loading...');
              var resultxmail="";
              var errorxmail="Some of the form(s) are not added to database.please enter the records.";
              var resultxmail;
              Ext.Ajax.request({
                                 url : 'read-qmail-queue-add-to-db.cgi',
                                 success: function ( result, request ) {
                                          resultxmail=result.responseText;
                                          Ext.getBody().unmask();
                                          dsmailstatus.load({params:{start: 0, limit: 100}});
                                          if(resultxmail=="ERR1")
                                             {
                                               Ext.MessageBox.show({
                                                                 title:'Data Selection Error', msg: errorxmail
                                                                });
                                             }
                                }
                         });
           }

          function mailstatuscsv()
             {
               Ext.MessageBox.confirm('Export Remote Mail Status?', '<b>Are you sure you want to export remote mail status?<br/>There require few more time...</b>',
              function (btn) {
                if (btn == 'yes') {
                                  var u ="";
                                  alert(masterkeyx);
                                  u="mailmanagementmailstatuscsv.cgi?"+masterkeyx;
                                  window.open(u,'_self');
                                }
                  });
             }
          var tabmailstatus = new Ext.Panel({
             region: 'center',
             margins:'3 0 3 3',
             cmargins:'3 3 3 3',
             layout:'fit',
              tbar:[{
text: 'Export Remote Mail Status',id:'remailstatuscsv', name:'remailstatuscsv', iconCls:'icon-arrowdown',
                         listeners:{
                        click:{ fn:mailstatuscsv}
                         }
                }],
             bbar:[{
                     text: 'Delete Selected',id:'maildeleteselected',name:'maildeleteselected', iconCls:'icon-minus',
                     listeners:{click:{fn:
                         gridmailstatus.getSelectionModel().on('rowselect', function(smmailstatus, rowIdx, r) {
                          })
                      }}
                   }, '-', {
                     text: 'Reload Mail Status',id:'mailstatusreload',name:'mailstatusreload', iconCls:'icon-refresh',
                   listeners:{
                       click:{ fn:funreloadmailstatus}
                       }
                   }],
                       items:[gridmailstatus]
           });

          var winmanagementmailstatus7 = new Ext.Window({
                 id:'mailstatuswin',
                 name:'mailstatuswin',
                 title: 'QMail Queue Status',
                 closable:false,
                 width: 750,
                 height:350,
                 iconCls:'icon-email',
                 layout: 'fit',
                 plain:true,
                 maximizable:false,
                 minimizable:false,
                 border:true,
                 region:'center',
                 frame:true,
                 resizable:true,
                 onEsc: Ext.emptyFn,
                 items:tabmailstatus
            });
         winmanagementmailstatus7.show();
         ds.load({params:{start: 0, limit: 15}});
        }); 
 
 
          </script>
 
     </head>
           <body>
                <script type="text/javascript" src="ext-2.2/examples/shared/examples.js"></script><!-- EXAMPLES -->
  
           </body>
</html>

XYZXYZ
