({
    onInit : function(component, event, helper) {
		var remoteMethod = component.get("c.GetPicklistValues"),
        	cmpSpinner = component.find('InProgress');

        remoteMethod.setParams({
            "picklistNames": [ 'CabinetColorList', 'ProductList' ],
            "picklistObjects": [ 'Account', 'Contact' ],
		});

		console.log(['Request Picklist Values', remoteMethod.getParams()]);
		remoteMethod.setCallback(this, function(response) {
			if (response.getState() == "ERROR")
				helper.IncomingError(component, response, helper);
			else if (response.getState() == "INCOMPLETE") 
				helper.IncompleteRequest(component, response, helper);
            else if (response.getState() == "SUCCESS") {
                console.log(['Received Picklist Values', response.getReturnValue()]);
	        	var cmpSpinner = component.find('InProgress');
        		$A.util.addClass(cmpSpinner, 'slds-hide');
				                
                component.set('v.picklistValues', response.getReturnValue());
            }
	    });
      	$A.enqueueAction(remoteMethod); 
	},
    
	recordUpdated : function(component, event, helper) {
		
	}
})