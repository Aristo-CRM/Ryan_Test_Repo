({
	onInit : function(component, event, helper) {
        var field = component.get('v.field'),
            apiField = component.get('v.apiField');
        
        if (!field && apiField) {
            console.log(['Init Field', event]);
        	var action = component.get("c.GetFieldProperties"),
            	objName = apiField.substring(0, apiField.indexOf('.')),
                fieldName = apiField.substring(apiField.indexOf('.') + 1)
            
            action.setParams({
                objectName : objName,
                fieldName : fieldName
            });
            
            // Register the callback function
            action.setCallback(this, function(response) {
                var retVal = response.getReturnValue();
                console.log(retVal);
                component.set('v.field', retVal);
            });
            
            // Invoke the service
            $A.enqueueAction(action);
        }
	},

    handleValueChange : function(component, event, helper) {
        console.log(['Ext OnChange Event', JSON.parse(JSON.stringify(event))]);
        var current = component.get('v.internalVal'),
            newVal = component.get('v.value');

        if (current != newVal) {
            console.log(['CustomInput (ex): a -> b', current, newVal]);
            component.set('v.internalVal', newVal);
        }
    },

    valueChanged : function(component, event, helper) {
        console.log(['Int OnChange Event', event]);
        var compEvents = component.getEvent("fieldValueChange"),
            field = component.get('v.field'),
            extValue = component.get('v.value'),
            value = component.get('v.internalVal');

        //if (value != extValue) {
            compEvents.setParams( { 
                "name": field.name,
                "value": value });
            
            compEvents.fire();
        //}
    },

    lookupChange : function(component, event, helper) {
        console.log(['Int Lookup OnChange Event', event]);
        var compEvents = component.getEvent("fieldValueChange"),
            field = component.get('v.field'),
            extValue = component.get('v.value'),
            value = component.get('v.internalVal');

        //if (value != extValue) {
        compEvents.setParams( { 
            "name": field.name,
            "value": value });
        
        compEvents.fire();
    }
})