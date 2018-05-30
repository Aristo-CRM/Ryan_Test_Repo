({
	inputChanged : function(component, event, helper) {
		var record = component.get('v.record'),
            fields = component.get('v.fields'),
            
            targetFields = [];

        console.log('InputChanged');

        if (!record || !fields) return;
        
        for (var item in fields) {
            var newVal = record[fields[item].name];
            targetFields.push({
                fieldDef: fields[item],
                value: newVal ? newVal : null
            });
        }

        var currentRec = component.get('v.recordField'),
            diff = true;

        if (currentRec) diff = helper.trackChanges(helper, currentRec, targetFields);
        if (diff) {
            console.log(['Actual difference:', diff]);
            component.set('v.recordField', targetFields);
        }
	},

    handleValueChange : function(component, event, helper) {
        console.log(['Record Value Changed', event]);
        
        var record = component.get('v.record'),
            index = component.get('v.index'),
            value = event.getParam('value'),
            name = event.getParam('name');

        if (record[name] != value) {
            component.set('v.record['+name+']', value);

            var compEvents = component.getEvent("recordValueChange");        
            compEvents.setParams({ 
                "name": "RecordChange",
                "value": { 
                    "record": record,
                    "name": name,
                    "value": value,
                    "index": index } 
            });
            
            compEvents.fire();
        }
        
        var newData = JSON.parse(JSON.stringify(record));
        newData[name] = value;
        console.log(JSON.stringify(newData));
    }
})