({
	doInit: function(component, event, helper) {
		var action = component.get("c.GetContactList");
        action.setParams({
	        accountId : component.get("v.recordId"),
            offset : 0
    	});
        
        // Register the callback function
        action.setCallback(this, function(response) {
            var retVal = response.getReturnValue();
            console.log(retVal);
            component.set('v.docData', response.getReturnValue());
        });
        
        // Invoke the service
        $A.enqueueAction(action);
    },
    
    changeInput: function(component, event, helper) {
        console.log('change');
    },

    gotoURL : function (component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL"),
            newUrl = '/apex/dsfs__DocuSign_CreateEnvelope?',
            DST = 'DST=';

        urlEvent.setParams({
            "url": newUrl
        });

        component.log(newUrl);
        // urlEvent.fire();
    }
})