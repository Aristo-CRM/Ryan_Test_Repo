({    
	onInit : function(component, event, helper) {
	    var evt = $A.get("e.force:navigateToComponent"),
	    	oppId = component.get('v.recordId');

	    evt.setParams({
	        componentDef : "c:ATIQuoteDraft",
	        componentAttributes: {
	            'oppId' : oppId
	        }
	    });
	    evt.fire();
	}
})