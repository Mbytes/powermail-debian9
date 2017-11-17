
Ext.onReady(function() {

	// Note: For the purposes of following along with the tutorial, all 
	// new code should be placed inside this method.  Delete the following
	// line after you have verified that Ext is installed correctly.
	
//	alert("Congratulations!  You have Ext configured correctly!");
	var myDiv = Ext.get('myDiv');
	myDiv.highlight();
	myDiv.addClass('red');
	myDiv.center();	
	myDiv.setOpacity(.25);

//	Ext.select('p').highlight();		

	Ext.get('myButton').on('click', function(){
        alert("You clicked the button");
    	});

/*	Ext.select('p').on('click', function() {
		alert("You clicked a paragraph");
	});
*/

var paragraphClicked = function(e) {
  //    alert("You clicked a paragraph");
//	Ext.get(e.target).highlight();

	
        var paragraph = Ext.get(e.target);
        paragraph.highlight();

        Ext.MessageBox.show({
        title: 'Paragraph Clicked',
        msg: paragraph.dom.innerHTML,
        width:400,
        buttons: Ext.MessageBox.OK,
        animEl: paragraph
	});
	}
    Ext.select('p').on('click', paragraphClicked);


});

