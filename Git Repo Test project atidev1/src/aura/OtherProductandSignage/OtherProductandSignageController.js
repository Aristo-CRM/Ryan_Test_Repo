({
	onInit : function(component, event, helper) {
        var combobox = {
                        "label":"Does the customer require?",
                        "name":"Discovery_Completed__c",
                        "type":"boolean"};
        
        var combobox1 = {
                        "label":"Is this a new Lightning Link Install?",
                        "name":"Discovery_Completed__c",
                        "type":"boolean"};
         var combobox2 = {
                        "label":"Will the lightning Link be installed on 1 bank?",
                        "name":"Discovery_Completed__c",
                        "type":"boolean"};
         var combobox3 = {
                        "label":"Will the Machine/Conversion go onto an existing bank of LL EGM's?",
                        "name":"Discovery_Completed__c",
                        "type":"boolean"};
        
        var combobox4 = {
                        "label":"2nd Bank of Lightning Link",
                        "name":"Discovery_Completed__c",
                        "type":"boolean"};
        
        var combobox5 = {
                        "label":"3rd Bank of Lightning Link",
                        "name":"Discovery_Completed__c",
                        "type":"boolean"};
        
        var combobox6 = {
                        "label":"4th Bank of Lightning Link",
                        "name":"Discovery_Completed__c",
                        "type":"boolean"};
        
        var hubname = {
			"byteLength":120,
			"calculated":false,
			"digits":0,
			"htmlFormatted":false,
			"idLookup":false,
			"label":"Hub Name",
			"length":40,
			"name":"Hub Name",
			"permissionable":false,
			"picklistValues":[				
				{"active":true,"defaultValue":false,"label":"Yes","value":"Yes"},
				{"active":true,"defaultValue":false,"label":"No","value":"No"}],
			"restrictedPicklist":false,
			"type":"picklist",
			"nillable":false,
			"updateable":true };
        
        var field2 = {
			"byteLength":120,
			"calculated":false,
			"digits":0,
			"htmlFormatted":false,
			"idLookup":false,
			"label":"AsrockMedia Player",
			"length":40,
			"name":"AsrockMedia Player",
			"permissionable":false,
			"picklistValues":[				
				{"active":true,"defaultValue":false,"label":"Yes","value":"Yes"},
				{"active":true,"defaultValue":false,"label":"No","value":"No"}],
			"restrictedPicklist":false,
			"type":"picklist",
			"nillable":false,
			"updateable":true };
        
        var field3 = {
			"byteLength":120,
			"calculated":false,
			"digits":0,
			"htmlFormatted":false,
			"idLookup":false,
			"label":"Controller",
			"length":40,
			"name":"Controller",
			"permissionable":false,
			"picklistValues":[				
				{"active":true,"defaultValue":false,"label":"Yes","value":"Yes"},
				{"active":true,"defaultValue":false,"label":"No","value":"No"}],
			"restrictedPicklist":false,
			"type":"picklist",
			"nillable":false,
			"updateable":true };
        
        var field4 = {
			"byteLength":120,
			"calculated":false,
			"digits":0,
			"htmlFormatted":false,
			"idLookup":false,
			"label":"HDMI Kit",
			"length":40,
			"name":"HDMI Kit",
			"permissionable":false,
			"picklistValues":[				
				{"active":true,"defaultValue":false,"label":"Yes","value":"Yes"},
				{"active":true,"defaultValue":false,"label":"No","value":"No"}],
			"restrictedPicklist":false,
			"type":"picklist",
			"nillable":false,
			"updateable":true };
        
        var field5 = {
			"byteLength":120,
			"calculated":false,
			"digits":0,
			"htmlFormatted":false,
			"idLookup":false,
			"label":"HDMI Add on Kit",
			"length":40,
			"name":"HDMI Add on Kit",
			"permissionable":false,
			"picklistValues":[				
				{"active":true,"defaultValue":false,"label":"Yes","value":"Yes"},
				{"active":true,"defaultValue":false,"label":"No","value":"No"}],
			"restrictedPicklist":false,
			"type":"picklist",
			"nillable":false,
			"updateable":true };
        
        var field6 = {
			"byteLength":120,
			"calculated":false,
			"digits":0,
			"htmlFormatted":false,
			"idLookup":false,
			"label":"SEI",
			"length":40,
			"name":"SEI",
			"permissionable":false,
			"picklistValues":[				
				{"active":true,"defaultValue":false,"label":"Yes","value":"Yes"},
				{"active":true,"defaultValue":false,"label":"No","value":"No"}],
			"restrictedPicklist":false,
			"type":"picklist",
			"nillable":false,
			"updateable":true };
        
        var textarea = {
                        "label":"Comments",
                        "name":"Comments",
                        "type":"textarea"};
        
        var emailText = {
            "label":"CC:",
                        "name":"CC:",
                        "type":"string"};
        
        var x = { 
			'combobox' : combobox,
            'combobox1': combobox1,
            'combobox2': combobox2, 
            'combobox3': combobox3,
            'combobox4': combobox4,
            'combobox5': combobox5,
            'combobox6': combobox6,
            'field2':field2,
            'field3':field3,
            'field4':field4,
            'field5':field5,
            'field6':field6,
            'textarea':textarea,
            'hubname':hubname,
            'emailText':emailText
		};
        
        
		
		component.set('v.Fields', x);
		component.set('v.testDate', '2018-11-05');
		component.set('v.testValue', { label: 'test', value: '001abcdefghijkl' });
		console.log(['Options:', x]);
	},
    
    addLineItem : function(component, event, helper) {
		var items = component.get('v.lineItems');
        items.push({ Quantity: 1});
        component.set('v.lineItems', items);
	}
})