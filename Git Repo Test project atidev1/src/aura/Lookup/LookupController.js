({
	onInit : function(component, event, helper) {
		var remoteMethod = component.get("c.GetRecentItems"),
			objectTypes = component.get("v.field.referenceTo");
        
		remoteMethod.setParams({
			"objectTypes": objectTypes
		});

		var objIcon = objectTypes[0] ? objectTypes[0].toLowerCase() : 'record'
		if (objIcon.endsWith('2')) 
			objIcon = objIcon.substring(0, objIcon.length-1);

		component.set("v.cmpData", {
			requestId : 0,
		  	delayFunc : (
			  	function() {
				  	var timer = 0;
				  	return function(callback, ms){
				    	clearTimeout (timer);
				    	if (ms) timer = setTimeout(callback, ms);
				  	}
				})(), 
			activeType: objectTypes[0], 
			objectIcon: objIcon,
			selectedId: "-1",
			searchText: '',
			isOpen: false,
			dataSet: [], 
			RecentItems: {} } 
		);

		console.log(['Request Recent Items', remoteMethod.getParams()]);
		remoteMethod.setCallback(this, function(response) {
			console.log(['Response Recent Items', response.getState(), response.getReturnValue()]);
			if (response.getState() == "ERROR")
				helper.IncomingError(component, response, helper);
			else if (response.getState() == "INCOMPLETE") 
				helper.IncompleteRequest(component, response, helper);
			else if (response.getState() == "SUCCESS") {		
				var retVal = response.getReturnValue(),
					objectType = component.get("v.cmpData.activeType");
	        	component.set("v.cmpData.RecentItems", retVal);
	        	component.set("v.cmpData.dataSet", retVal[objectType]);
	        }
	    });
      	$A.enqueueAction(remoteMethod); 

      	// component.find('lookup-control').set('v.autocomplete', 'false');
      	helper.turnOffAutocomplete(component);
	},

	selectItem : function(component, event, helper) {
		var selectedIndex = component.get('v.cmpData.selectedId'),
			selItem = component.get('v.cmpData.dataSet')[selectedIndex],

			newSelection = { value: selItem.Id, label: selItem.Name};

		component.set('v.cmpData.isOpen', false);
		// component.set('v.value', newSelection);
		helper.SetNewValue(component, newSelection);
		helper.FocusControl(component, 'lookup-control');
	},

	focusIn : function(component, event, helper) {
		var value = component.get('v.value');
		component.set('v.cmpData.isOpen', !value);
	},

	focusOut : function(component, event, helper) {
		setTimeout(function() {
			component.set('v.cmpData.isOpen', false);
		}, 200);
	},

	removeValue : function(component, event, helper) {
		//component.set('v.value', null);
		helper.SetNewValue(component, null);
		helper.FocusControl(component, 'lookup-control');
	},

	searchValueChange : function(component, event, helper) {
		var delayFunc = component.get('v.cmpData.delayFunc'),
			timeOutMsec = 240,
			searchTxt = event.target.value;

		if (!searchTxt) {
			var dataSet = component.get("v.cmpData.RecentItems"),
				objectType = component.get("v.cmpData.activeType");

			component.set("v.cmpData.dataSet", dataSet[objectType]);
			component.set('v.cmpData.searchText', '');
			component.set('v.cmpData.isOpen', true);
		} else if (searchTxt.length <= 2) {
			component.set('v.cmpData.searchText', '');		
			component.set('v.cmpData.dataSet', []);	
			
			// Hide progress spinner
			//var cmpSpinner = component.find('ABNSearchProgress');
			//$A.util.addClass(cmpSpinner, 'slds-hide');

			// prevent displaying results from prior request:
			helper.NextRequestId(component);	
			
			// Cancel existing timer
			timeOutMsec = null;
		} else {
			delayFunc(function() {
				if(component.isValid()) {
					// perform search action
					if (searchTxt && searchTxt.length > 2) 
						helper.Search(component, searchTxt, helper);
				}
			}, timeOutMsec);
		}
	},

	valueChange : function(component, event, helper) {
		var objectType = component.get('v.cmpData.activeType'),
			recentItems = component.get('v.cmpData.RecentItems');

		component.set('v.cmpData.selectedId', '-1');
		component.set('v.cmpData.searchText', '');

		component.set("v.cmpData.dataSet", recentItems[objectType]);
	},

	hoverItem : function(component, event, helper) {
		console.log(['Mouse On event ', event]);
		var itemIndex = event.srcElement.id,
			itemCount = component.get("v.cmpData.dataSet.length"),
			sep = itemIndex.indexOf('-') + 1,
			idx = itemIndex ? parseInt(itemIndex.substring(sep)) : 0,

			items = component.find('lookup-item');

		component.set('v.cmpData.selectedId', idx);
		
		if ($A.util.isArray(items)) 
	    	for (var i=0; i<items.length; i++)
	    		$A.util.removeClass(items[i], 'slds-has-focus');
		else $A.util.removeClass(items, 'slds-has-focus');
	},

	keyPress : function(component, event, helper) {
		console.log(['Key pressed ', event]);
		var value = component.get("v.cmpData.dataSet.length"),
			itemIndex = event.srcElement.getAttribute("aria-activedescendant");

		if (!itemIndex) return;

		var
			itemCount = component.get("v.cmpData.dataSet.length"),
			sep = itemIndex.indexOf('-') + 1,
			idx = itemIndex ? parseInt(itemIndex.substring(sep)) : 0;
		
		if (event.keyCode == 38 && !value) // key_up
			idx = (idx + itemCount - 1) % itemCount;
		else if (event.keyCode == 40) // key_down
			idx = (idx + 1) % itemCount;
		else if (event.keyCode == 27 && !value) { // escape
			component.set('v.cmpData.isOpen', false);
			return;
		} else if (event.keyCode == 13 && !value) { // enter
			var selItem = component.get('v.cmpData.dataSet')[idx],
				newSelection = { value: selItem.Id, label: selItem.Name};

			component.set('v.cmpData.isOpen', false);
			//component.set('v.value', newSelection);
			helper.SetNewValue(component, newSelection);
			helper.FocusControl(component, 'lookup-control');
			return;
		} else if (event.keyCode == 46 && value) { // delete
			component.set('v.value', null);
			helper.FocusControl(component, 'lookup-control');
			return;
		} else return;

		component.set('v.cmpData.selectedId', idx);
		itemIndex = itemIndex.substring(0, sep) + idx;
		event.srcElement.setAttribute("aria-activedescendant", itemIndex);
		
		var items = component.find('lookup-item');
		console.log(items);
		if ($A.util.isArray(items)) 
	    	for (var i=0; i<items.length; i++)
	    		if (i==idx) $A.util.addClass(items[i], 'slds-has-focus');
	    		else  $A.util.removeClass(items[i], 'slds-has-focus');
		else $A.util.addClass(items, 'slds-has-focus');
	}
})