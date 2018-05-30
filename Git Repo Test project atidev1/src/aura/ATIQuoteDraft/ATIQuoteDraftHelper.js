({
	GetOrderDetails : function(component, helper) {
        var remoteMethod = component.get("c.GetQuoteDetails"),
            recordId = component.get('v.recordId'),
            oppId = component.get('v.oppId');

        remoteMethod.setParams({
            "recordId": recordId || oppId
        });

        helper.GetRequiredPicklistValues(helper, component);

        remoteMethod.setCallback(this, function(response) {
            console.log(['Response Recent Items', response.getState(), response.getReturnValue()]);
            if (response.getState() == "ERROR")
                helper.IncomingError(component, response, helper);
            else if (response.getState() == "INCOMPLETE") 
                helper.IncompleteRequest(component, response, helper);
            else if (response.getState() == "SUCCESS") {        
                var retVal = response.getReturnValue(),
                    orderLineItems = [],
                    conversionLineItems = [];

                if (retVal) {
                    component.set('v.cmpSettings.data', retVal);
                }
            }
        });
        $A.enqueueAction(remoteMethod); 
    },

    saveRecord : function(component, helper) {        
        component.find("recordViewForm").submit();
	},

    IncompleteRequest : function(component, response, helper) {
        var //cmpSpinner = component.find('Progress'),
            toastEvent = $A.get("e.force:showToast");
        
        //$A.util.addClass(cmpSpinner, 'slds-hide');          

        toastEvent.setParams({
            mode: 'sticky',
            title: "Error",
            message: "Cannot complete search request. Please check your connection!"
        });

        toastEvent.fire();
    },

    IncomingError : function(component, errText) {
        var //cmpSpinner = component.find('Progress'),
            toastEvent = $A.get("e.force:showToast");

        //$A.util.addClass(cmpSpinner, 'slds-hide');  

        toastEvent.setParams({
            mode: 'sticky',
            title: 'Error',
            type: 'error',
            message: errText ? errText : "Cannot complete request. Server error occurred!"
        });

        toastEvent.fire();      

        // console.log(['Request Search ERROR:', response.getError()[0].message, response]);
    },

    ShowMessage : function(component, msgText) {
        var toastEvent = $A.get("e.force:showToast");

        toastEvent.setParams({
            message: msgText,
            type: 'success',
            mode: 'pester'
        });

        toastEvent.fire();
    } ,

    formatDate : function(date) {
        var day = date.getDate();
        var month = date.getMonth() + 1;
        var year = date.getFullYear();

        return day + '/' + month + '/' + year;
    },

    GetDefaultValues : function(helper, component) {
        var data = component.get('v.cmpSettings.data'),
            quoteLineItems = [];

        for (var item in data.OpportunityLineItems) {
            var lineItem = data.OpportunityLineItems[item],
                itemPreferences = data.CustomerPreference[lineItem.Product2.Model__c],
                quoteLineItem = {
                    Model : (lineItem && lineItem.Product2) ? lineItem.Product2.Model__c : null,
                    Quantity : lineItem.Quantity,
                    GameName : lineItem.Game_Title__c,
                    PMM : itemPreferences ? itemPreferences.PMM__c : null,
                    Printer : itemPreferences ? (itemPreferences.Printer__c ? 'Yes' : 'No') : null
                }

            quoteLineItems.push(quoteLineItem);
        }

        return quoteLineItems;
    },

    GetRequiredPicklistValues : function(helper, component) {
        var fieldDefs = helper.FieldSettings(helper, component),
            items = {
                predefined: [],
                basedOn: []
            };

        for (var part in fieldDefs) {
            var fieldGroup = fieldDefs[part];
            for (var field in fieldGroup) {
                var field = fieldGroup[field];
                if (field['type'] == 'picklist' 
                    && field.meta && field.meta.picklist) {
                    if (field.meta.picklist.predefined)
                        items.predefined.push(field.meta.picklist.predefined);
                    else if (field.meta.picklist.basedOn) 
                        items.basedOn.push(field.meta.picklist.basedOn);
                }
            }
        }

        if (items.predefined.length > 0 || items.basedOn.length > 0) {
            var remoteMethod = component.get("c.GetPicklists");

            remoteMethod.setParams({
                "preDefPicklists": items.predefined,
                "basedOnPicklists": items.basedOn
            });
        
            remoteMethod.setCallback(this, function(response) {
                console.log(['Response Recent Items', response.getState(), response.getReturnValue()]);
                if (response.getState() == "ERROR")
                    helper.IncomingError(component, response, helper);
                else if (response.getState() == "INCOMPLETE") 
                    helper.IncompleteRequest(component, response, helper);
                else if (response.getState() == "SUCCESS") {        
                    var retVal = response.getReturnValue();
                    if (retVal) helper.PushFieldSettings(helper, component, retVal);
                }
            });
            $A.enqueueAction(remoteMethod); 
        }

        console.log(['Items', items]);
    },

    PushFieldSettings: function(helper, component, valueSets) {
        var fieldDefs = helper.FieldSettings(helper, component);

        for (var part in fieldDefs) {
            var fieldGroup = fieldDefs[part];
            for (var field in fieldGroup) {
                var field = fieldGroup[field];
                if (field['type'] == 'picklist' && field.meta && field.meta.picklist) {
                    if (field.meta.picklist.predefined && valueSets.predefined[field.meta.picklist.predefined])
                        field.picklistValues = valueSets.predefined[field.meta.picklist.predefined].picklistValues;
                    else if (field.meta.picklist.basedOn && valueSets.basedOn[field.meta.picklist.basedOn]) 
                        field.picklistValues = valueSets.basedOn[field.meta.picklist.basedOn]; 
                }
            }
        }

        component.set('v.cmpSettings.metadata', fieldDefs);
    },

    UpdateForm : function(component, helper) {
        var record = component.get('v.recordData'),
            lineItemData = { };

        console.log(['New Record Data', record ? JSON.stringify(record) : null]);
        
        component.set('v.readOnly', record.Status__c != 'Draft');

        var titles = [
            { label: 'Account Name',
              value: {
                id: record.Customer_Id__c,
                label: record.Customer_Name__c }},
            { label: 'Region',
              value: record.Region__c },
            { label: 'Responsible BDE',
              value: {
                id: record.BDE_Id__c,
                label: record.BDE_Name__c }},
            { label: 'Primary Contact',
              value: null /*{
                id: record.BDE_Id__c,
                label: record.BDE_Name__c } */},
            { label: 'Status',
              value: record.Status__c },
            { label: 'Date',
              value: helper.formatDate(new Date()) }
         ];

        component.set('v.titleFields', titles);
        
        // if (record && record.Contents__c)
        //  lineItemData = JSON.parse(record.Contents__c);

        // component.set('v.orderLineItems', lineItemData);
    }, 

    FieldSettings : function(helper, component) {
      var fieldDefinitions = {
        quoteLineItems : [
          { 'name': 'Contract', 
            'label': 'Contract', 
            "nillable":false,
            'type': 'string' },

          { 'name': 'Model', 
            'label': 'Model',  
            'columnSize': 12,
            "nillable":false,
            'type': 'picklist',
            'meta': { 
              'picklist': {
                'basedOn' : 'Customer_Preference__c.Model__c'}},
            "picklistValues":[]},
            
          { 'name': 'GameName', 
            'label': 'Game Name', 
            "nillable":false,
            'type': 'picklist',
            'columnSize': 8,
            'meta': { 
              'picklist': {
                'basedOn' : 'OpportunityLineItem.Game_Title__c'}},
            "picklistValues":[]},

          { 'label' : 'Qty', 
            'name': 'Quantity', 
            'minValue': 1,
            "nillable":false,
            'type': 'int',
            'defaultValue': 1},

          { 'label' : 'Denom', 
            'name': 'denom', 
            'meta': {
                'picklist': {
                    'predefined': 'Denomination'}},
            'type': 'picklist',
            "picklistValues":[]},

          { 'label' : 'Var', 
            "nillable":false,
            'name': 'var', 
            'meta': {
                'picklist': {
                    'predefined': 'Var'}},
            'type': 'picklist',
            "picklistValues":[]},

          { "name":"coin",
            "label":"Coin",
            "nillable":false,
            'meta': {
                'picklist': {
                    'predefined': 'YesNo'}},
            "picklistValues":[],
            "type":"picklist"},

          { "name":"hopper",
            "label":"Hopper",
            "nillable":false,
            'meta': {
                'picklist': {
                    'predefined': 'YesNo'}},
            "picklistValues":[],
            "type":"picklist"},

          { "name":"Printer",
            "label":"Printer",
            "nillable":false,
            "type":"picklist",            
            'meta': {
                'picklist': {
                    'predefined': 'YesNo'}},
            "picklistValues":[]},

          { "name":"coinBlank",
            "label":"Coin Blank",
            "nillable":false,
            "type":"picklist",            
            'meta': {
                'picklist': {
                    'predefined': 'YesNo'}},
            "picklistValues":[]},

          { "name":"spacers",
            "label":"Spacers",
            "nillable":false,
            "picklistValues":[],
            'meta': {
                'picklist': {
                    'predefined': 'Spacers'}},  
            "type":"picklist"},

          { "name":"infills",
            "label":"Infills",
            "nillable":false,
            "type":"picklist",            
            'meta': {
                'picklist': {
                    'predefined': 'InFills'}},
            "picklistValues":[]}, 

          { "name":"PMM",
            "label":"PMM (Systems)",
            "nillable":false,
            "meta": {
                "picklist": {
                    "basedOn":"Customer_Preference__c.PMM__c" }},
            "picklistValues":[],
            "type":"picklist"},

          { "name":"topper",
            "label":"Topper",
            "nillable":false,
            "picklistValues":[],
            'meta': {
                'picklist' : {
                    'predefined': 'Topper' }},
            "type":"picklist"},

          { "name":"lcdTrim",
            "label":"LCD Trim",
            "nillable":false,
            "type":"picklist",            
            'meta': {
                'picklist': {
                    'predefined': 'YesNo'}},
            "picklistValues":[]},

          { "name":"promo",
            "label":"Promo Code",
            "nillable":true,
            "picklistValues":[],
            "type":"string"}
        ],

        conversionLineItems : [
           {'label' : 'Contract', 
            'name': 'Contract', 
            'type': 'string'},

           {'label' : 'From: Game', 
            'name': 'fGame', 
            "type": 'picklist',
            'columnSize': 8,
            'meta': { 
              'picklist': {
                'basedOn' : 'OpportunityLineItem.Game_Title__c'}},
            "picklistValues":[]},

           {'label' : 'From: Model', 
            'name': 'Model', 
            'type': 'picklist',
            'meta': { 
              'picklist': {
                'basedOn' : 'Customer_Preference__c.Model__c'}},
            "picklistValues":[]},
           
           {'label' : 'From: Serial Number', 
            'name': 'Serial', 
            'type': 'string'},
           
           
            {'label': 'From: Topper',
            'name':'FromTopper__c', 
            'nillable':false,
            'meta': {
                'picklist' : {
                    'predefined': 'Topper' }},
            'picklistValues': [], 
            'type':'picklist'},

            {'label' : 'To: Game', 
            'name': 'Game', 
            'type': 'picklist',
            'meta': { 
              'picklist': {
                'basedOn' : 'OpportunityLineItem.Game_Title__c'}},
            "picklistValues":[]},
           
           {'label': 'Denomination',
            'name':'denom', 
            'nillable':false,
            'meta': {
                'picklist': {
                    'predefined': 'Denomination'}},
            'picklistValues': [], 
            'type':'picklist'},
           
           {'label': 'Var',
            'name':'var', 
            'nillable':false,
            'meta': {
                'picklist': {
                    'predefined': 'Var'}},
            'picklistValues': [], 
            'type':'picklist'},
           
           {'label': 'To: Topper',
            'name':'Toppr__c', 
            'nillable':false,
            'meta': {
                'picklist' : {
                    'predefined': 'Topper' }},
            'picklistValues': [], 
            'type':'picklist'},
           
           {'label': 'Midtrim Colour',
            'name':'Midtrim_Colour__c', 
            'nillable':false,
            'meta': {
                'picklist' : {
                    'predefined': 'Midtrim_Colour' }},
            'picklistValues': [], 
            'type':'picklist'},
           
           {'label' : 'Promo', 
            "hint" : "Provide value if applicable",
            'nillable':true,
            'name': 'promo', 
            'type': 'string'}  
        ],

        tradeInLineItems : [
           {'label' : 'Game', 
            'name': 'game', 
            'type': 'string',
            "picklistValues":[]},

           {'label' : 'From: Serial Number', 
             'name': 'fModel', 
             'type': 'string'}
        ],

        sparePartLineItems : [
           {'label' : 'Item', 
            'name': 'item', 
            'nillable':false,
            "hint" : "Name of the item",
            'type': 'string'},

           {'label' : 'Quantity', 
            'type': 'int',
            'minValue': 1,
            'nillable':false,
            'defaultValue': 1,
            'name': 'qty'}, 

           {"label" : "Price",
            'nillable': true,
            'type': 'currency'}
        ]
      };

      return fieldDefinitions;
    }
})