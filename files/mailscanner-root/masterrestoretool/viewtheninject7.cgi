#!/usr/bin/perl
require './mailboxes-lib.pl';
&ReadParse();


print "Content-type: text/html\n\n";

print <<"XYZXYZ";
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Master Email Restore for Table(date) : $in{'tableok'}</title>

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
<script language="javascript" type="text/javascript">
/*
Auto center window script- Eric King (http://redrival.com/eak/index.shtml)
Permission granted to Dynamic Drive to feature script in archive
For full source, usage terms, and 100's more DHTML scripts, visit http://dynamicdrive.com
*/

var win = null;
function NewWindow(mypage,myname,w,h,scroll){
LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
settings =
'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',resizable'
win = window.open(mypage,myname,settings)
}
</script>

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

var encodeda = "$in{'sqlx'}";
           var dsmailstatus = new Ext.data.JsonStore({
           url:'viewjson.cgi?tableok=$in{'tableok'}&sqlx='+encodeda,
           method: 'POST',
           totalProperty: 'data.total',
           root: 'data.results',
           fields: [
                    {name:'emailfrom'},
                    {name:'emailfromdomain'},
                    {name:'emailto'},
                    {name:'emailtodomain'},
                    {name:'subject'},
                    {name:'mailstorepath'},
                    {name:'emaildatetime'},
                    {name:'emaildate'},
{name:'mailsize'}
                  ],
            sortInfo: {field: 'emaildate', direction: 'DESC'},
            remoteSort:true
           });


dsmailstatus.on('beforeload', function(p, params) {
params.tableok='$in{'tableok'}',params.sqlx="$in{'sqlx'}"

});

             dsmailstatus.load();
 
          var filtermailstatus = new Ext.grid.GridFilters({
                 remote:true,
                 filters:[
                          {type: 'string', dataIndex: 'emailfrom'},
                          {type:'string', dataIndex: 'emailfromdomain'},
                          {type: 'string', dataIndex: 'emailto'},
                          {type: 'string', dataIndex: 'emailtodomain'},
                          {type: 'string', dataIndex: 'subject'},
{type: 'numeric', dataIndex: 'mailsize'}
            ]});
//       var smmailstatus = new Ext.grid.CheckboxSelectionModel();
         var cmmailstatus = new Ext.grid.ColumnModel([
  //             smmailstatus,
                       {header: "Mail From", width: 90, sortable: true,dataIndex:'emailfrom'},
                       {header: "Mail To", width: 120, sortable: true,dataIndex:'emailto'},
                       {header: "Email Date", width: 90, sortable: true,dataIndex:'emaildatetime'},
                       {header:  "Mail Subject", width: 160, sortable: true,renderer:subject,dataIndex:'subject'},
{header: "Archive File", width: 10, sortable: false,dataIndex:'mailstorepath'},
{header: "Mail Size", width: 120, sortable: true, dataIndex:'mailsize'}
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
                     var msgfilename = record.get('mailstorepath');
                                 if(fieldName=='subject')
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
                 /* var winmailstatusclick= new Ext.Window({
                          id:'mailstatusclickwin',
                          name:'mailstatusclickwin',
                          title: 'Showing Single Email Details',
                          closable:true,
                 width: 1000,
                 height:590,
                 layout: 'fit',
                 plain:true,
                 border:true,
                 region:'center',
                 autoScroll:true,
                 onEsc: Ext.emptyFn,
                            html:'<iframe src="view_mail.cgi?myemailfile='+msgfilename+'" height=550 width=990 scrolling="auto" frameborder="0" align="top">',
                  frame:true,
                 resizable:true
                     });
             winmailstatusclick.show();
*/
var udownfile="getmailcontentfirst.cgi?idte=&mailstorepath="+msgfilename;
//window.open(udownfile);
// window.open(udownfile,'sd','400','400','yes');
NewWindow(udownfile,'sdsdsd1','800','500','yes');


           }
/////////////////////////////////

          function mailstatuscsv()
             {
               Ext.MessageBox.confirm('Export Email Archive Log Reports?', '<b>Are you sure you want to export bounce mail reports?<br/>There require few more time...</b>',
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

//dsmailstatus.on('beforeload', function(p, params) {
//params.tableok='$in{'tableok'}',params.sqlx="$in{'sqlx'}"

//}
function startdatesearch(){
//alert("dfgdfg");
//dsmailstatus.on('beforeload', function(p, params) {


//var startDate = "";
     //    var endDate = "";
//         if(Ext.getCmp('mailstatedfrom').getValue() !== "") {
  //          startDate = Ext.getCmp('mailstatedfrom').getValue().format('Y-m-d');
  //        alert(startDate);
    //     }
        // if(Ext.getCmp('mailstatedto').getValue() !== "") {
         //   endDate = Ext.getCmp('mailstatedto').getValue().format('Y-m-d');
         //  alert(endDate);
        // }

//dsmailstatus.load({params:{start: 0, limit: 100, startDate: startDate, endDate: endDate}});
dsmailstatus.baseParams = {
//startDate: startDate,
tableok: '$in{'tableok'}',sqlx: "$in{'sqlx'}"
}
dsmailstatus.load({
    params: {
        start: 0,
        limit: 100
    }
});
//alert(startDate);
//alert(endDate);
//alert("fghf");
//params.mailstatedfrom=startDate;
//params.mailstatedto=endDate;

//});
}

//////////////////////////////////////////
          var tabmailstatus = new Ext.Panel({
             region: 'center',
             margins:'3 0 3 3',
             cmargins:'3 3 3 3',
             layout:'fit',

 
                       items:[gridmailstatus]
           });
////////////////////////////////

          var winmanagementmailstatus7 = new Ext.Window({
                 id:'mailstatuswin',
                 name:'mailstatuswin',
                 title: 'Master Email Restore Tool View for Table(Date):$in{'tableok'} ',
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
