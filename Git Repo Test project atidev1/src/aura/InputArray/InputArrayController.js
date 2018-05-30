({
    onInit : function(component, event, helper) {
        console.log('Init');
        component.set('v.isMobileDevice', $A.get("$Browser.formFactor") != 'DESKTOP');
    },

	addItem : function(component, event, helper) {
		var items = component.get('v.records'),
            fields = component.get('v.fields'),
            newRecord = {},
            customEvents = component.get('v.customEvents');

        if (!items) return;

        for (var f in fields) {
            var def = fields[f].defaultValue;
            newRecord[fields[f].name] = def ? def : null;
        }

        if (!customEvents) {
            items.push(newRecord);
            component.set('v.records', items);
        } else {
            helper.FireNewItemEvent(component, newRecord, helper);
        }
	},
    
    clickMenu: function(component, event, helper) {
        var clickedMenuItem = event.getParam("value"),
        	itemIndex = event.getSource().get('v.name'),

			sep = itemIndex.indexOf('-') + 1,
			idx = itemIndex ? parseInt(itemIndex.substring(sep)) : 0,

			records = component.get('v.records');
		
        console.log(['Menu Item Clicked', event]);
        if (clickedMenuItem == 'menuRemove') {        	
        	records.splice(idx, 1);
        	component.set('v.records', records);
        } else if (clickedMenuItem == 'menuClone') {
        	var cloneItem = records[idx],
        		newItem = JSON.parse(JSON.stringify(cloneItem));
        	
        	records.push(newItem);        	
        	component.set('v.records', records);
        }
    },

    clone : function(component, event, helper) {
            var itemIndex = event.getSource().get('v.name'),

                sep = itemIndex.indexOf('-') + 1,
                idx = itemIndex ? parseInt(itemIndex.substring(sep)) : 0,
                
                records = component.get('v.records'),
                cloneItem = records[idx],
                newItem = JSON.parse(JSON.stringify(cloneItem));
            
            records.push(newItem);          
            component.set('v.records', records);
    },

    selectAll : function(component, event, helper) {
    	console.log(['Select All', event]);
    	var items = component.find('select-row'),
    		value = event.getSource().get('v.checked');

    	if (items) {
	    	if (!$A.util.isArray(items)) items = [items];
	    	for (var i in items)
	    		items[i].set('v.checked', value);
		}

    	var btn = component.find('bntRemove');
        if (btn) btn.set('v.disabled', !items || items.length == 0);
    },

    selectRow : function(component, event, helper) {
    	console.log(['Select Row', event]);
    	var items = component.find('select-row'),
    		selCount = 0;

		if (!$A.util.isArray(items)) items = [items];
	    for (var i=0; i<items.length; i++)
	    	if (items[i].get('v.checked')) selCount++;		

        var btn = component.find('bntRemove');
		if (btn) btn.set('v.disabled', selCount == 0);
    },

    removeItems : function(component, event, helper) {
    	var items = component.find('select-row'),
    		indices = [],

    		records = component.get('v.records');

    	if (!$A.util.isArray(items)) items = [items];
	    for (var i in items) 
	    	if (items[i].get('v.checked')) 
	    		indices.unshift(i);
	    
	    for (var i in indices)
	    	records.splice(indices[i], 1);

	    component.set('v.records', records);
        if (component.find('bntRemove')) component.find('bntRemove').set('v.disabled', true);
	    if (component.find('check-toprow')) component.find('check-toprow').set('v.checked', false);
    },

    handleValueChange : function(component, event, helper) {
        console.log(['RecordSet Value changed', event]);

        var params = event.getParams();

        component.set('v.records['+params.value.index+'].'+params.value.name, params.value.value);

        var records = component.get('v.records'),
            compEvents = component.getEvent("recordSetValueChange");
        
        component.set('v.recordData', JSON.stringify(records));     
        
        compEvents.setParams( { 
            "name": 'recordSet',
            "value": records });
        
        compEvents.fire();
    }
})