GO.customfields.nonGridTypes = ['GO\\Customfields\\Customfieldtype\\Textarea','GO\\Customfields\\Customfieldtype\\Html', 'GO\\Customfields\\Customfieldtype\\Header', 'GO\\Customfields\\Customfieldtype\\Infotext'];

GO.customfields.addColumns=function(link_type, fields){
	if(GO.customfields.columns[link_type])
	{
		for(var i=0;i<GO.customfields.columns[link_type].length;i++)
		{
			if(GO.customfields.nonGridTypes.indexOf(GO.customfields.columns[link_type][i].datatype)==-1){
                                if(GO.customfields.columns[link_type][i].exclude_from_grid != 'true')
                                {
                                        fields.fields.push(GO.customfields.columns[link_type][i].dataIndex);
                                        fields.columns.push(GO.customfields.columns[link_type][i]);
                                }
			}
		}
	}
}

GO.customfields.getMatchingFieldNamesMap = function(sourceLinkId, targetLinkId){

	var sourceFields={};
	for(var i=0;i<GO.customfields.types[sourceLinkId].panels.length;i++)
	{
		var p = GO.customfields.types[sourceLinkId].panels[i];
		for(var n=0;n<p.customfields.length;n++){
			sourceFields[p.customfields[n]['name']]=p.customfields[n]['dataname'];
		}
	}

	var map = {};
	for(var i=0;i<GO.customfields.types[targetLinkId].panels.length;i++)
	{
		var p = GO.customfields.types[targetLinkId].panels[i];
		for(var n=0;n<p.customfields.length;n++){
			if(sourceFields[p.customfields[n]['name']]){
				map[sourceFields[p.customfields[n]['name']]]=p.customfields[n]['dataname'];
			}
		}
	}
	return map;
}

GO.customfields.getFormField = function(customfield, config){

	config = config || {};
	if(!GO.customfields.dataTypes[customfield.datatype]){
		GO.log("Could not find custom field of type: "+customfield.datatype+". Is this module installed?");
		return false;
	}

	return GO.customfields.dataTypes[customfield.datatype].getFormField(customfield, config);

}


GO.customfields.MainPanel = function(config){

	if(!config)
	{
		config = {};
	}

	var northPanel = new Ext.Panel({
		region: 'north',
		cls:'go-form-panel',
		waitMsgTarget:true,
		html: '<div class="go-important-icon">'+GO.customfields.lang.restart.replace('Group-Office', GO.settings.config.product_name)+'</div>',
		border: true,
		split: true,
		height:55,
		resizable:false

	});

	this.typePanel = new GO.customfields.TypePanel({
		region:'center',
		border: true
	});

	var navData = [];

	for(var link_type in GO.customfields.types)
	{
		navData.push([link_type, GO.customfields.types[link_type].name]);
	}

	var navStore = new Ext.data.SimpleStore({
		fields: ['link_type', 'name'],
		data : navData
	});

	this.navMenu= new GO.grid.SimpleSelectList({
		store: navStore
	});


	this.navMenu.on('click', function(dataview, index){

		var link_type = dataview.store.data.items[index].data.link_type;
		this.typePanel.setLinkType(link_type);
		this.typePanel.store.load();

	}, this);

	this.navPanel = new Ext.Panel({
		region:'west',
		title:GO.lang.menu,
		autoScroll:true,
		width: dp(280),
		split:true,
		resizable:true,
		items:this.navMenu
	});



	config.items=[
	northPanel,
	this.navPanel,
	this.typePanel
	];

	config.tbar=new Ext.Toolbar({
		cls:'go-head-tb',
		items:[{
                xtype:'htmlcomponent',
                html:GO.customfields.lang.name,
                cls:'go-module-title-tbar'
        },new Ext.Button({
			iconCls: 'btn-setting',
			text: GO.customfields.lang['manageBlocks'],
			cls: 'x-btn-text-icon',
			handler: function(){
				if (!GO.customfields.manageBlocksWindow) {
					GO.customfields.manageBlocksWindow = new GO.Window({
						title : GO.customfields.lang['manageBlocks'],
						items: [this.manageBlocksGrid = new GO.customfields.ManageBlocksGrid({layout:'fit',height:490})],
						width: 800,
						height: 600,
						layout: 'fit'
					});
					GO.customfields.manageBlocksWindow.on('show',function(){
						this.manageBlocksGrid.store.load();
					},this);
				}
				GO.customfields.manageBlocksWindow.show();
			},
			scope: this
		})]
	});

	config.layout='border';
	GO.customfields.MainPanel.superclass.constructor.call(this, config);

};


Ext.extend(GO.customfields.MainPanel, Ext.Panel, {
	afterRender : function(){
		GO.customfields.MainPanel.superclass.afterRender.call(this);
	}
});


GO.customfields.categoriesStore = new GO.data.JsonStore({
	//url: GO.settings.modules.customfields.url+'json.php',
	url:GO.url('customfields/category/store'),
	totalProperty: "count",
	baseParams:{
		link_type:0
	},
	root: "results",
	id: "id",
	fields:[
	'id',
	'name'
	]
});


GO.customfields.displayPanelTemplate =
	'<tpl if="customfields.length">'+
	'<tpl for="customfields">'+
'{[this.collapsibleSectionHeader(values.name, "cf-"+parent.panelId+"-"+values.id, "cf-"+values.id)]}'+
'<table cellpadding="0" cellspacing="0" border="0" class="display-panel" id="cf-{parent.panelId}-{id}">'+

'<tpl for="fields">'+
'<tpl if="!value">'+
'<tr>'+
'<td class="table_header_links" colspan="2">{name}</td>'+
'</tr>'+
'</tpl>'+
'<tpl if="value && value.length">'+
	'<tr>'+
	'<td>{name}:</td>'+
	'{[GO.customfields.renderType(values)]}'+
	'</tr>'+
'</tpl>'+
'</tpl>'+
'</table>'+
'</tpl>'+
'</tpl>';

GO.customfields.renderType = function(data) {
	switch(data.datatype) {
		case 'GO\\Customfields\\Customfieldtype\\FunctionField':
		case 'GO\\Customfields\\Customfieldtype\\Number':
			return '<td style="text-align: right;">'+data.value+'</td>';
		case 'GO\\Files\\Customfieldtype\\File':
			return '<td>'+data.value+'</td>'; /* '<td>'+data.value+'</td>'+
				'<td style="white-space:nowrap;"><a onclick="" style="display:block;float: right;" class="go-icon btn-edit" href="#">&nbsp;</a></td>';*/
		default:
			return '<td>'+data.value+'</td>';
	}
};

GO.customfields.displayPanelBlocksTemplate =
'<tpl if="items_under_blocks">'+'<tpl if="items_under_blocks.length">'+
	'<tpl for="items_under_blocks">'+
	'{[this.collapsibleSectionHeader(values.block_name, "block-"+parent.panelId+"-"+values.id,"block")]}'+
//	'{[this.collapsibleSectionHeader(values.block_name, "block-"+parent.panelId+"-"+values.id, "block-"+values.id)]}'+
		'<table cellpadding="0" cellspacing="0" border="0" class="display-panel" id="block-{parent.panelId}-{values.id}">'+
			'<tpl for="items">'+
				'<tr>'+
				'<td class="table_header_links" style="width:30px;">'+
					'<div class="display-panel-link-icon go-model-icon-{[this.replaceWithUnderscore(values.model_name)]}" ext:qtip="{values.type}">'+'</div>'+
				'</td>'+
				'<td class="table_header_links">'+
					'<a href="#" onclick="GO.linkHandlers[\'{[values.model_name.replace(/\\\\/g, \'\\\\\\\\\')]}\'].call(this,{model_id});">{item_name}</a>'+
				'</td>'+
				'</tr>'+
			'</tpl>'+
		'</table>'+
	'</tpl>'+
'</tpl>'+'</tpl>';



/*
 * This will add the module to the main tabpanel filled with all the modules
 */

if(GO.settings.modules.customfields.write_permission)
{
	GO.moduleManager.addModule('customfields', GO.customfields.MainPanel, {
		title : GO.customfields.lang.customfields,
		iconCls : 'go-tab-icon-customfields',
		admin :true
	});
}else
{
	GO.moduleManager.onAddModule('customfields');
}
