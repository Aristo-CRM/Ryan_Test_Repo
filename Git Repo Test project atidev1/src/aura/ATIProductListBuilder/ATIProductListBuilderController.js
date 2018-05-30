({
	onInit : function(component, event, helper) {		
		var cmpData = {
				'search': [],
				'recentItems': [],
				'lookup': [],
				'records': [] };

		component.set('v.cmpData', cmpData);
		helper.GetRecentProducts(component, helper);
		helper.GetProductList(component, helper);
	},

	cmpChange : function(component, event, helper) {
		var index = event.getParam('index'),
			oldValue = event.getParam('oldValue'),
			value = event.getParam('value');

		console.log(['Value Changed', index, oldValue, value]);

		switch(index) {
			case 'recentItems': 
				break;
			case 'records':
				break;
		}

	}
})