#!/opt/lampp/bin/perl


print "Content-type: text/html\n\n";

print <<"EOF";
<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">//-->

<html>
<head>
   <title>DHTML Grid samples. dhtmlXGrid - Using Grid API - Smart Rendering</title>
   <meta name="KEYWORDS" content="dhtmlxgrid, dhtml grid, javascript grid, javascript, DHTML, grid, grid control, dynamical scrolling, xml, AJAX, API, cross-browser, checkbox, XHTML, compatible, gridview, navigation, script, javascript navigation, web-site, dynamic, javascript grid, dhtml grid, dynamic grid, item, row, cell, asp, .net, jsp, cold fusion, custom tag, loading, widget, checkbox, drag, drop, drag and drop, component, html, scand">

<meta name="DESCRIPTION" content="Cross-browser DHTML grid with XML support and powerful API. This DHTML JavaScript grid can load its content dynamically from server using AJAX technology.">

</head>
<style>
   body {font-size:12px}
   .{font-family:arial;font-size:12px}
   h1 {cursor:hand;font-size:16px;margin-left:10px;line-height:10px}
   xmp {color:green;font-size:12px;margin:0px;font-family:courier;background-color:#e6e6fa;padding:2px}
   div.hdr{
      background-color:lightgrey;
      margin-bottom:10px;
      padding-left:10px;
   }
    .grid_hover {
        background-color:#7FFFD4;
        font-size:20px;
    }

</style>
<body>
   <div class="hdr">DHTML JavaScript Grid samples </div>
   <h1>Smart Rendering - dynamic mode</h1>
   <p>Known limitation - scrolling by mouse wheel not supported in Opera and Safari.</p>
   <link rel="STYLESHEET" type="text/css" href="css/dhtmlXGrid.css">
   <script  src="js/dhtmlXCommon.js"></script>
   <script  src="js/dhtmlXGrid.js"></script>
   <script  src="js/dhtmlXGrid_srnd.js"></script>
   <script  src="js/dhtmlXGridCell.js"></script>
   <table width="600">
      <tr>
         <td width="50%" valign="top">
            <div id="gridbox" width="100%" height="250px" style="background-color:white;"></div>
         </td>

      </tr>
      <tr>
         <td>
                <div id="a_1"></div>
         </td>
      </tr>
   </table>
<hr>
<XMP>
    <script>
        mygrid = new dhtmlXGridObject('gridbox');
        ...
          mygrid.init();
       mygrid.enableSmartRendering(true,2000);
//       mygrid.loadXML("dynload.php");
    </script>
</XMP>

<script>


   mygrid = new dhtmlXGridObject('gridbox');
   mygrid.setImagePath("imgs/");
   mygrid.setHeader("Order,Index 1,Request info");
   mygrid.setInitWidths("50,275,250")
   mygrid.setColAlign("right,left,left")
   mygrid.setColTypes("ed,ed,ed");
   mygrid.setColSorting("int,str,str")
   mygrid.setColumnColor("white,#d5f1ff,#d5f1ff")
   mygrid.init();
    mygrid.enableSmartRendering(true,2000);
  //  mygrid.loadXML("dynload.php");


</script>
<br><br>
<p><a href="http://www.scbr.com/docs/products/dhtmlxGrid/index.shtml" style="font-weight:bold;">Go to the dhtmlxGrid main page</a> or <a href="javascript:self.close()">Close this page</a></p>
   
</body>
</html>

EOF

