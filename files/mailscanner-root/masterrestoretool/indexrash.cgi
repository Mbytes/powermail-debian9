#!/usr/bin/perl

print "Content-type: text/html\n\n";

print <<"XYZXYZ";
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Bounce Mail Reports</title>

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
 <style type="text/css">
        html, body {
            font: normal 12px verdana;
            margin: 0;
            padding: 0;
            border: 0 none;
            overflow: hidden;
            height: 100%;
        }
    </style>
   <style type="text/css">
                .x-grid3-hd-row td.ux-filtered-column {
        font-style: italic;
        font-weight: bold;
    }
        </style>


    <style type="text/css">
    .x-panel-body p {
        margin:10px;
    }
    #container {
        padding:10px;
    }
    </style>

 <style type="text/css">
    #loading-mask{
        position:absolute;
        left:0;
        top:0;
        width:100%;
        height:100%;
        z-index:20000;
        background-color:white;
    }
#loading{
        position:absolute;
        left:45%;
        top:40%;
        padding:2px;
        z-index:20001;
        height:auto;
    }
    #loading a {
        color:#225588;
    }
    #loading .loading-indicator{
        background:white;
        color:#444;
        font:bold 13px tahoma,arial,helvetica;
        padding:10px;
        margin:0;
        height:auto;
    }
    #loading-msg {
        font: normal 10px arial,tahoma,sans-serif;
    }

    #sample-ct {
        border:1px solid;
 border-color:#dadada #ebebeb #ebebeb #dadada;
  padding:2px;
    }

    #all-demos h2 {
        border-bottom: 2px solid #99bbe8;
        cursor:pointer;
        padding-top:6px;
    }
    #all-demos .collapsed h2 div {
        background-position: 3px 3px;
    }
  #all-demos .collapsed dl {
        display:none;
    }
    .x-window {
        text-align:left;
    }
    </style>
<style>
        .upload-icon {
            background: url('ext-2.2/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;
        }
        #fi-button-msg {
            border: 2px solid #ccc;
            padding: 5px 10px;
            background: #eee;
            margin: 5px;
            float: left;
        }
    </style>

         
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
           url:'mailstatusgrid.cgi',
           method: 'POST',
           totalProperty: 'data.total',
           root: 'data.results',
           fields: [
                    {name:'bounce_mail_from'},
                    {name:'bounce_mail_to'},
                    {name:'bounce_mail_time_delivery_log'},
                    {name:'bounce_mail_time_delivery'},
                    {name:'bounce_mail_subject'},
                    {name:'bounce_mail_for_email_id'},
                    {name:'bounce_mail_normal_error'},
                       {name:'bounce_mail_technical_error'},
{name:'bounce_mail_qmail_process_id'},
{name:'bounce_mail_ms_archive_file'},
{name:'bounce_mail_size'}
                  ],
            sortInfo: {field: 'bounce_mail_time_delivery_log', direction: 'DESC'},
            remoteSort:true
           });
             dsmailstatus.load();
 
          var filtermailstatus = new Ext.grid.GridFilters({
                 remote:true,
                 filters:[
                          {type: 'string', dataIndex: 'bounce_mail_from'},
                          {type:'string', dataIndex: 'bounce_mail_to'},
                          {type: 'string', dataIndex: 'bounce_mail_time_delivery_log'},
                          {type: 'string', dataIndex: 'bounce_mail_time_delivery'},
                          {type: 'string', dataIndex: 'bounce_mail_subject'},
                          {type: 'string', dataIndex: 'bounce_mail_for_email_id'},
                          {type: 'string', dataIndex: 'bounce_mail_normal_error'},
                              {type: 'string', dataIndex: 'bounce_mail_technical_error'},
{type: 'numeric', dataIndex: 'bounce_mail_qmail_process_id'},
{type: 'string', dataIndex: 'bounce_mail_ms_archive_file'},
{type: 'numeric', dataIndex: 'bounce_mail_size'}
            ]});
//       var smmailstatus = new Ext.grid.CheckboxSelectionModel();
         var cmmailstatus = new Ext.grid.ColumnModel([
  //             smmailstatus,
                       {header: "Mail From", width: 90, sortable: true,dataIndex:'bounce_mail_from'},
                       {header: "Mail To", width: 120, sortable: true,dataIndex:'bounce_mail_to'},
                       {header: "Time Delivery Log", width: 120, sortable: true,dataIndex:'bounce_mail_time_delivery_log'},
                       {header: "Time Delivery", width:120, sortable: true,dataIndex:'bounce_mail_time_delivery'},
                       {header:  "Mail Subject", width: 90, sortable: true,renderer:subject,dataIndex:'bounce_mail_subject'},
                       {header: "Mail For Email ID", width: 90, sortable: true,dataIndex:'bounce_mail_for_email_id'},
                       {header: "Normal Error", width: 60, sortable: true,dataIndex:'bounce_mail_normal_error'},
                    {header: "Technical Error", width: 100, sortable: true,dataIndex:'bounce_mail_technical_error'},
{header: "Qmail Process ID", width: 120, sortable: true, dataIndex:'bounce_mail_qmail_process_id'},
{header: "MS Archive File", width: 120, sortable: true,dataIndex:'bounce_mail_ms_archive_file'},
{header: "Mail Size", width: 120, sortable: true, dataIndex:'bounce_mail_size'}
            ]);
            cmmailstatus.defaultSortable = true;
          var gridmailstatus = new Ext.grid.GridPanel({
                     id: 'gridmailstatus',
                     ds:dsmailstatus,
                     cm:cmmailstatus,
               //      sm:smmailstatus,
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
                     var msgfilename = record.get('bounce_mail_ms_archive_file');
                                 if(fieldName=='bounce_mail_subject')
                                               {
                                                     rashfunmailstatus(subject,msgfilename);
                                               }
                                      }
                     ,scope:this
                  }
           });
//////////////
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
                 border:true,
                 region:'center',
                 autoScroll:true,
                 onEsc: Ext.emptyFn,
                            html:'<iframe src="view_mail.cgi?myemailfile='+msgfilename+'" height=420 width=732 scrolling="auto" frameborder="0" align="top">',
                  frame:true,
                 resizable:true
                     });
             winmailstatusclick.show();
           }
/////////////////////////////////

          function mailstatuscsv()
             {
               Ext.MessageBox.confirm('Export Bounce Mail Reports?', '<b>Are you sure you want to export bounce mail reports?<br/>There require few more time...</b>',
              function (btn) {
                if (btn == 'yes') {
                                  var u ="";
                                  //alert(masterkeyx);
                                  u="mailmanagementmailstatuscsv.cgi?"+masterkeyx;
                                  window.open(u,'_self');
                                }
                  });
             }
////////////////////////////////////

//////////////////////////////////////////
          var tabmailstatus = new Ext.Panel({
             region: 'center',
             margins:'3 0 3 3',
             cmargins:'3 3 3 3',
             layout:'fit',
              tbar:[{xtype:'tbfill'},{
text: 'Export Bounce Mail Reports',id:'remailstatuscsv', name:'remailstatuscsv', iconCls:'icon-arrowdown',
                         listeners:{
                        click:{ fn:mailstatuscsv}
                         }
                }],
                       items:[gridmailstatus]
           });
////////////////////////////////

          var winmanagementmailstatus7 = new Ext.Window({
                 id:'mailstatuswin',
                 name:'mailstatuswin',
                 title: 'Bounce Mail Reports',
                 width: 750,
                 height:350,
                 iconCls:'icon-email',
               closable:false,
                 layout: 'fit',
                 plain:true,
               listeners: {
                            show: function() {

                                winmanagementmailstatus7.maximize();
}
},

                 minimizable:false,
                 border:true,
                 region:'center',
                 frame:true,
                 resizable:true,
                 onEsc: Ext.emptyFn,
                 items:tabmailstatus
            });
         winmanagementmailstatus7.show();
      //   ds.load({params:{start: 0, limit: 15}});
        }); 
 
 
          </script>
 
     </head>
           <body>
                <script type="text/javascript" src="ext-2.2/examples/shared/examples.js"></script><!-- EXAMPLES -->
  
           </body>
</html>

XYZXYZ
