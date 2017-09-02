// billing Overrides
// projects2 Overrides


GO.moduleManager.onModuleReady('projects2',function(){
	
	//GO.projects2.SettingsDialog 
	 
	Ext.override(GO.projects2.SettingsDialog, {
		
		buildForm : GO.projects2.SettingsDialog.prototype.buildForm.createSequence(function(){
			
//			if(GO.settings.has_admin_permission){
				this.settingsPanel = new GO.exactonline.SettingsPanel();
				
				this.addPanel(this.settingsPanel);
//			}
		})
		
	})
	
})


