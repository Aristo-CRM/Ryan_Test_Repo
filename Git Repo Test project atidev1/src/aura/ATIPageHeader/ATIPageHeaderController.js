({
	navigate : function(component, event, helper) {
		console.log(['navigate']);
		var id = event.target.id,
			navEvt = $A.get("e.force:navigateToSObject");

		if (navEvt && id) {
		    navEvt.setParams({
		      "recordId": id,
		      "slideDevName": "related"
		    });

		    navEvt.fire();		
		}
	}
})