({
	GetRecentProducts : function(component, helper) {
		var remoteMethod = component.get('c.GetRecentProducts'),
			pricebookId = component.get('v.pricebookId'),
            oppId = component.get('v.recordId');

        remoteMethod.setParams({
            "pricebookId": pricebookId
        });

        remoteMethod.setCallback(this, function(response) {
            console.log([
				'Response Recent Products', 
				response.getState(), 
				JSON.parse(JSON.stringify(response.getReturnValue()))]);

            if (response.getState() == "ERROR")
                helper.IncomingError(component, response, helper);
            else if (response.getState() == "INCOMPLETE") 
                helper.IncompleteRequest(component, response, helper);
            else if (response.getState() == "SUCCESS") { 				
                var retVal = response.getReturnValue();
                component.set('v.cmpData.recentItems', retVal);
            }
        });
        $A.enqueueAction(remoteMethod); 
	},

	GetRecentProducts : function(component, helper) {
		var remoteMethod = component.get('c.GetRecentProducts'),
			pricebookId = component.get('v.pricebookId'),
            oppId = component.get('v.recordId');

        remoteMethod.setParams({
            "pricebookId": pricebookId
        });

        remoteMethod.setCallback(this, function(response) {
            console.log([
				'Response Recent Products', 
				response.getState(), 
				JSON.parse(JSON.stringify(response.getReturnValue()))]);

            if (response.getState() == "ERROR")
                helper.IncomingError(component, response, helper);
            else if (response.getState() == "INCOMPLETE") 
                helper.IncompleteRequest(component, response, helper);
            else if (response.getState() == "SUCCESS") { 				
                var retVal = response.getReturnValue();
                component.set('v.cmpData.recentItems', retVal);
            }
        });
        $A.enqueueAction(remoteMethod); 
	},

	GetProductList: function(component, helper) {
		var remoteMethod = component.get('c.GetProductList'),
			pricebookId = component.get('v.pricebookId'),
            oppId = component.get('v.recordId');

        remoteMethod.setParams({
			"pricebookId": pricebookId,
			"search": ""
		});

        remoteMethod.setCallback(this, function(response) {
            console.log([
				'Response Recent Products', 
				response.getState(), 
				JSON.parse(JSON.stringify(response.getReturnValue()))]);

            if (response.getState() == "ERROR")
                helper.IncomingError(component, response, helper);
            else if (response.getState() == "INCOMPLETE") 
                helper.IncompleteRequest(component, response, helper);
            else if (response.getState() == "SUCCESS") { 				
                var retVal = response.getReturnValue();
                component.set('v.cmpData.recentItems', retVal);
            }
        });
        $A.enqueueAction(remoteMethod); 
	},

    IncompleteRequest : function(component, response, helper) {
        var toastEvent = $A.get("e.force:showToast");

        toastEvent.setParams({
            mode: 'sticky',
            title: "error",
            message: "Cannot complete search request. Please check your connection!"
        });

        toastEvent.fire();
    },

    IncomingError : function(component, errText) {
        var toastEvent = $A.get("e.force:showToast");

        toastEvent.setParams({
            mode: 'sticky',
            title: 'Error',
            type: 'error',
            message: errText ? errText : "Cannot complete request. Server error occurred!"
        });

        toastEvent.fire();      
	},
	
	SyncSearchResults : function(component, helper) {
		var search = component.get('v.cmpData.search');
		
	}
})