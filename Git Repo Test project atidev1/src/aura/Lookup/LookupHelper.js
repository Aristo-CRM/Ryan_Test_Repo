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
	},

	NextRequestId : function(component) {
		var res = component.get('v.cmpData.requestId') + 1;
		component.set('v.cmpData.requestId', res);

		return res;
	},

	Search : function(component, searchTxt, helper) {
		var remoteMethod = component.get('c.GetSearchResults'),
        	cmpSpinner = component.find('Progress');

		remoteMethod.setParams({
			"searchTxt": searchTxt,
			"requestId": helper.NextRequestId(component),
			"objectType": component.get('v.cmpData.activeType')
		});

		component.set('v.cmpData.dataSet', []);	
		component.set('v.cmpData.searchText', searchTxt);

		console.log(['Request Search', remoteMethod.getParams()]);
		remoteMethod.setCallback(this, function(response) {
			if (response.getState() == "ERROR")
				helper.IncomingError(component, response, helper);
			else if (response.getState() == "INCOMPLETE") 
				helper.IncompleteRequest(component, response, helper);
			else if (response.getState() == "SUCCESS") {
	        	console.log(['Response', event]);
	        	var retVal = response.getReturnValue();
                if (retVal.requestId === component.get('v.cmpData.requestId')) {
                    component.set('v.cmpData.dataSet', retVal.results);
                    component.set('v.cmpData.isOpen', true);
                }
			}
	    });
      	$A.enqueueAction(remoteMethod); 
	},

	FocusControl : function(component, cmpName) {
		setTimeout(function() {
			component.find(cmpName).getElement().focus();
		}, 50);
	},

	SetNewValue : function(component, newSelection) {
		var prevSelection = component.get('v.value');
		if (prevSelection != newSelection) {
			component.set('v.value', newSelection);
			
			var compEvents = component.getEvent("lookupEvent");
	        compEvents.setParams( { 
	            "name": 'change',
	            "value": {
	            	'newValue': newSelection,
	            	'field': component.get('v.field')}
	        });
	        
	        compEvents.fire();
	    }
	},

	turnOffAutocomplete : function(component) {
		/*
	    var input = component.find('lookup-control')
	    
	    if(input && input.get("autocomplete") !== "off")
	        input.set("autocompelte","off");
		*/

	    
	}
})