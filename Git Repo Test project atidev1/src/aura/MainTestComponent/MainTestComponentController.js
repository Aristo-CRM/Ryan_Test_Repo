({
	onInit : function(component, event, helper) {
	},

	toggle : function(component, event, helper) {
		var show = component.get('v.show');
		component.set('v.show', !show);
	}
})