GO.projects2.ProjectGrid = Ext.extend(GO.grid.GridPanel,{
	sm: new Ext.grid.RowSelectionModel(),
	
	initComponent : function(){
		
		var columnModel =  new Ext.grid.ColumnModel({
			defaults:{
				sortable:true
			},
			columns:[
			{
				header: 'ID', 
				dataIndex: 'id',
				hidden:true
			},
			{
				header: GO.lang['strName'], 
				dataIndex: 'name'
			},
			{
				header: 'path', 
				dataIndex: 'path' ,
				sortable: false
			}
		]
		});
		
		
		
		
		
		
		Ext.apply(this, {
			
			autoScroll: true,
			split: true,
			cm: columnModel,
			view: new Ext.grid.GridView({
				autoFill: true,
				forceFit: true,
				emptyText: GO.addressbook.lang.noAddressbooks		
			}),
			
			loadMask: true,
			paging: true,
			store: new GO.data.JsonStore({
				url: GO.url("projects2/project/store"),
				baseParams: {
						permissionLevel: GO.permissionLevels.write
				},
				fields: ['id', 'name', 'path','acl_id'],
					remoteSort: true
			})
		});
		
		GO.projects2.ProjectGrid.superclass.initComponent.call(this);		
	}
})
	