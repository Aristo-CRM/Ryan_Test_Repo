({    
	onPreInit : function(component, event, helper) {
		var recordId = component.get('v.recordId'),
			oppId = component.get('v.oppId'),
			toggle = component.get('v.toggle'),
			settings = { 
				'initComplete' : false,
				'data' : null,
				'metadata' : null,
				'isMobileDevice' : ($A.get("$Browser.formFactor") != 'DESKTOP')
			};
		
		
		component.set('v.cmpSettings', settings);
		if (!toggle) component.set('v.toggle', {});
		if (!recordId && !oppId) return;

		if (oppId) component.find('inputOpp').set('v.value', oppId);


		helper.GetOrderDetails(component, helper);
	},

	onInitComplete : function(component, event, helper) {
		var settings = component.get('v.cmpSettings');

		if (!settings.metadata || !settings.data || settings.initComplete) return;

		var orderLineItems = [],
			conversionLineItems = [],
			tradeInLineItems = [],
			sparePartLineItems = [],
			data = settings.data.QuoteDetail;

		if (data && data.QuoteLineItems__c) 
			orderLineItems = JSON.parse(data.QuoteLineItems__c);
		else orderLineItems = helper.GetDefaultValues(helper, component);
		
		if (data && data.ConversionLineItems__c) 
			conversionLineItems = JSON.parse(data.ConversionLineItems__c);

		if (data && data.TradeInLineItems__c)
			tradeInLineItems = JSON.parse(data.TradeInLineItems__c);

		if (data && data.SparePartLineItems__c)
			sparePartLineItems = JSON.parse(data.SparePartLineItems__c);		
	
		component.set('v.orderLineItems', orderLineItems ? orderLineItems : []);
		component.set('v.conversionLineItems', conversionLineItems ? conversionLineItems : []);
		component.set('v.tradeInLineItems', tradeInLineItems ? tradeInLineItems : []);
		component.set('v.sparePartLineItems', sparePartLineItems ? sparePartLineItems : []);

    	component.set('v.cmpSettings.initComplete', true);
	},
        
	duplicateRecord : function(component, event, helper) {

		var toggle = component.get('v.toggle');
		toggle.duplicateModal = !toggle.duplicateModal;
		component.set('v.toggle', toggle);
	},

	saveRecord : function(component, event, helper) {
		// helper.saveRecord(component, helper);		
		helper.saveRecord(component, helper);
	},

	preSubmit : function(component, event, helper) {
		console.log(['Presubmit', event]);
	},

	submitRecord : function(component, event, helper) {
		var
			isEntitleMents = component.find('inputEntitlement').get('v.value') == 'Trade In',
			orderlineitems = component.get('v.orderLineItems') || [],
			tradeIns = component.get('v.tradeInLineItems') || [];

		if (orderlineitems.length == 0){
			helper.IncomingError(component, 'Quote Lines should at least contain 1 item!');
			return;
		}

		if (isEntitleMents && orderlineitems.length != tradeIns.length) {
			helper.IncomingError(component, 'Incorrect number of TradeIn Line Items: This should be equal to the amount of Quote Line Items!');
			return;
		}

		for (var item in tradeIns) {
			var tradeIn = tradeIns[item];
		}

		if (component.find('inputStatus'))
			component.find('inputStatus').set('v.value', 'Submitted');
		else component.set('v.status', 'Submitted');

		helper.saveRecord(component, helper);
	},

	// cancelRecord : function(component, event, helper) {
	// 	component.find('inputStatus').set('v.value', 'Cancelled');
	// 	helper.saveRecord(component, helper);
	// },

	toggle : function(component, event, helper) {
		console.log('toggle');

		var elem = event.target;
		while (!elem.getAttribute('aria-controls') && elem != null) {
			elem = elem.parentElement;
		}		

		if (!elem) return;

		var	section = elem.getAttribute('aria-controls'),
			toggle = component.get('v.toggle');

		toggle[section] = !toggle[section];

		component.set('v.toggle', toggle);
		return false;
	},

	handleValueChange : function(component, event, helper) {
		console.log(['Top level Record change event', event]);

		var name = event.getParams().name,
			value = event.getParams().value,
			newValue = value ? JSON.stringify(value) : null,

			mapping = {
				orderLineItems : 'v.orderLineItemsData',
				conversionLineItems : 'v.conversionLineItemsData',
				tradeInLineItems : 'v.tradeInLineItemsData',
				sparePartLineItems : 'v.sparePartLineItemsData'
			};

		// if (name == 'orderLineItems') {
		// 	var prevValue = component.get(orderLineItems);
		// 	if (prevValue != newValue)
		// 		component.set(mapping[name], newValue);
		// }

		if (mapping[name]) {
			var prevValue = component.get(mapping[name]);
			if (prevValue != newValue)
				component.set(mapping[name], newValue);
		}
	},

	lineItemChanged : function(component, event, helper) {
		var input = component.get('v.orderLineItems'),
			prevValue = component.get('v.orderLineItemsData');

		if (input != prevValue)
			component.set('v.orderLineItemsData', JSON.stringify(input));
	},

	handleSuccess : function(component, event, helper) {
		helper.ShowMessage(component, 'Record has saved!');
		var payload = event.getParams().response,
			priorRecId = component.get('v.recordId'),
			newRecId = payload.id || payload.record.id;

		if (priorRecId != newRecId)
			component.set('v.recordId', newRecId);
	},

	handleLoadComplete: function(component, event, helper) {
		var payload = event.getParams().recordUi,
			fields = payload.fields || payload.record.fields,
			record = { Id : payload.id || payload.record.id },
			priorRecId = component.get('v.recordId');
		
		for (var field in fields) 
			record[field] = fields[field].value;
		
		console.log(['Load Complete', payload]);

		if (priorRecId != record.Id)
			component.set('v.recordId', record.Id);

		component.set('v.recordData', record);
		helper.UpdateForm(component, helper);
	},

	runDuplicate : function(component, event, helper) {
		var remoteMethod = component.get("c.DuplicateRecord"),
            recordId = component.get('v.recordId'),
            oppId = component.find('newOppId').get('v.value');

        remoteMethod.setParams({
            "recordId": recordId,
            "newOppId": oppId
        });

        if (!oppId) return;

        remoteMethod.setCallback(this, function(response) {
            if (response.getState() == "ERROR")
                helper.IncomingError(component, response, helper);
            else if (response.getState() == "INCOMPLETE") 
                helper.IncompleteRequest(component, response, helper);
            else if (response.getState() == "SUCCESS") {                        
                var recId = response.getReturnValue(), 
					navEvt = $A.get("e.force:navigateToSObject");

			    navEvt.setParams({
			      "recordId": recId,
			      "slideDevName": "detail"
			    });
			    navEvt.fire();
            }
        });
        $A.enqueueAction(remoteMethod); 	
	}
})