GO.tickets.SelectAgent = Ext.extend(GO.form.ComboBoxReset, {	
	hiddenName:'agent_id',
	fieldLabel:GO.tickets.lang.agent,
	emptyText:GO.tickets.lang.nobody,
	valueField:'id',
	displayField:'name',
	store:GO.tickets.agentsStore,
	mode:'local',
	triggerAction:'all',
	editable:true,
	selectOnFocus:true,
	typeAhead: true,
	minChars: 1
});