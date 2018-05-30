({
	IncompleteRequest : function(component, response, helper) {
		var cmpSpinner = component.find('Progress'),
			toastEvent = $A.get("e.force:showToast");
		
		$A.util.addClass(cmpSpinner, 'slds-hide');			

        toastEvent.setParams({
        	mode: 'sticky',
            title: "Error",
            message: "Cannot complete search request. Please check your connection!"
        });

        toastEvent.fire();
	},

	IncomingError : function(component, response, helper) {
		var cmpSpinner = component.find('Progress'),
			toastEvent = $A.get("e.force:showToast");

		$A.util.addClass(cmpSpinner, 'slds-hide');	

        toastEvent.setParams({
        	mode: 'sticky',
            title: "Error",
            message: "Cannot complete search request."
        });

        toastEvent.fire();		

		console.log(['Request Search ERROR:', response.getError()[0].message, response]);
	}	
})