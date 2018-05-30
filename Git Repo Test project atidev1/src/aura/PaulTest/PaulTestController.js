({
	onInit : function(component, event, helper) {
		var fields = [
            {"label":"Account Name",
			"length":255,
			"name":"Name",
			"type":"string",
			"nillable":false,
			"updateable":true },            
         {
             "label":"Test Checkbox",
             "name":"TestCheckbox",
             "type":"boolean" },
		{
			"label":"Stage",
			"name":"StageName",
			"picklistValues":[
				{"active":true,"defaultValue":false,"label":"Prospecting","validFor":null,"value":"Prospecting"},
				{"active":true,"defaultValue":false,"label":"Qualification","validFor":null,"value":"Qualification"},
				{"active":true,"defaultValue":false,"label":"Needs Analysis","validFor":null,"value":"Needs Analysis"},
				{"active":true,"defaultValue":false,"label":"Value Proposition","validFor":null,"value":"Value Proposition"},
				{"active":true,"defaultValue":false,"label":"Closed Lost","validFor":null,"value":"Closed Lost"}],
			"type":"picklist",
			"nillable":false,
			"updateable":true },
		{
			"label":"Employees",
            "name":"NumberOfEmployees",
            "nillable":true,
            "type":"int",
            "updateable":true}, 
		{
			"label":"Close Date",
			"name":"CloseDate",
			"nillable":false,
            "type":"date",
            "updateable":true}
            ,
		{
			"aggregatable":true,"autoNumber":false,"byteLength":18,"calculated":false,"calculatedFormula":null,
			"cascadeDelete":false,"caseSensitive":false,"compoundFieldName":null,"controllerName":null,
			"createable":true,"custom":false,"defaultValue":null,"defaultValueFormula":null,
			"defaultedOnCreate":true,"dependentPicklist":false,"deprecatedAndHidden":false,
			"digits":0,"displayLocationInDecimal":false,"encrypted":false,"externalId":false,
			"extraTypeInfo":null,"filterable":true,"filteredLookupInfo":null,"groupable":true,
			"highScaleNumber":false,"htmlFormatted":false,"idLookup":false,"inlineHelpText":null,
			"label":"Account","length":18,"mask":null,"maskType":null,"name":"OwnerId",
			"nameField":false,"namePointing":false,"nillable":false,"permissionable":false,
			"picklistValues":[],"polymorphicForeignKey":false,"precision":0,"queryByDistance":false,
			"referenceTargetField":null,"referenceTo":["Account"],"relationshipName":"Account",
			"relationshipOrder":null,"restrictedDelete":false,"restrictedPicklist":false,"scale":0,
			"searchPrefilterable":false,"soapType":"tns:ID","sortable":true,"type":"reference",
			"unique":false,"updateable":true,"writeRequiresMasterRead":false}
		];
        
        var records = [
            {
                'Name': 'Record Name',
                'CloseDate': '2018/01/01',
                'TestCheckbox': false,
                'NumberOfEmployees': 16,
                'Account'  : null,
                'StageName': 'Needs Analysis' },                
            {
                'Name': 'Record Name 2',
                'CloseDate': null,
                'TestCheckbox': true,
                'NumberOfEmployees': 1500,
                'StageName': 'Qualification',
                'Account'  : { value: '003abcdefghijkln', label: 'Test Record'},
                'StageName': 'Closed Lost' }    
        ];
        component.set('v.fields', fields);
        component.set('v.records', records);
	}
})