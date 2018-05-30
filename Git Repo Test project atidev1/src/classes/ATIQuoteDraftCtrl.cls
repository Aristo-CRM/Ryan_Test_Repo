public class ATIQuoteDraftCtrl {
	@AuraEnabled
    public static Map<String, Object> GetQuoteDetails(String recordId) {                
        Quote_Tool_Drafts__c quoteDetail = null;
        String opportunityId = '';

        if (recordId.substring(0,3) == Quote_Tool_Drafts__c.sObjectType.getDescribe().getKeyPrefix()) {
            quoteDetail = [
                SELECT Id, Status__c, Opportunity__c,
                    QuoteLineItems__c, TradeInLineItems__c, 
                    SparePartLineItems__c, ConversionLineItems__c             
    			FROM Quote_Tool_Drafts__c
                WHERE Id = :recordId];

            opportunityId = quoteDetail.Opportunity__c;
        } else if (recordId.substring(0,3) == Opportunity.sObjectType.getDescribe().getKeyPrefix()) {
            opportunityId = recordId;
        }

        Opportunity opp = [
            SELECT Id, AccountId, Account.Name, Account.Owner.FirstName, Account.Owner.LastName
            FROM Opportunity
            WHERE Id = :opportunityId];

        List<OpportunityLineItem> oppLines = [
            SELECT Id, OpportunityId, Product2.Model__c, Quantity, Game_Title__c, Product2Id, Product2.Name
            FROM OpportunityLineItem
            WHERE OpportunityId = :opp.Id];

        //Account acc = [
        //    SELECT Id, Name
        //    FROM Account
        //    WHERE Id = :opp.AccountId];

        List<Customer_Preference__c> cps = [
            SELECT Id, Model__c,
            Printer__c, PMM__c
            FROM Customer_Preference__c
            WHERE Account__c = :opp.accountId
              AND Model__c != null];
        
        Map<String, Customer_Preference__c> cpByModelName = new Map<String, Customer_Preference__c>();
        for (Customer_Preference__c item :cps) 
            cpByModelName.put(item.Model__c, item);

        Map<String, Object> result = new Map<String, Object>{
            'QuoteDetail' => quoteDetail,
            // 'Account' => acc,
            'CustomerPreference' => cpByModelName,
            'Opportunity' => opp,
            'OpportunityLineItems' => oppLines
        };

        return result;
    }

    @AuraEnabled
    public static void SetQuoteDetails(Id recordId, string quoteLines, string conversionLines, string tradeInLines, string sparePartLines) {
		Quote_Tool_Drafts__c qtd = [
            SELECT Id, Status__c, Opportunity__c,
                QuoteLineItems__c, TradeInLineItems__c, 
                SparePartLineItems__c, ConversionLineItems__c                
            FROM Quote_Tool_Drafts__c
            WHERE Id = :recordId];

		if (qtd.Status__c != 'Draft') throw new NoAccessException();

		qtd.QuoteLineItems__c = quoteLines;
		qtd.SparePartLineItems__c = sparePartLines;
        qtd.TradeInLineItems__c = tradeInLines;
        qtd.ConversionLineItems__c = conversionLines;

		update qtd;	
    }

    @AuraEnabled
    public static Map<String, Object> GetPicklists(List<String> preDefPicklists, List<String> basedOnPicklists, List<String> customDef) {
        return new Map<String, Object> {
            'predefined' => GetPredefinedPicklists(preDefPicklists),
            'basedOn' => GetBasedOnPicklists(basedOnPicklists)
        };
    }

    @AuraEnabled
    public static String DuplicateRecord(string recordId, string newOppId) {
        Quote_Tool_Drafts__c originalRec = [
            SELECT Id, Controller__c, ConversionLineItems__c, CustomTopperRequirements__c, Description__c, Does_the_customer_require__c, 
                Graphics_Sequence__c, HDMI_Add_on_Kit__c, HDMI_Kit__c, InstallLinkOn1Bank__c, NewLinkInstall__c, P6_ManagerApproved__c, 
                Pricing__c, QuoteLineItems__c, 
                SEI__c, SparePartLineItems__c, Special_Discount__c, TargetIsExistingEGMBankLink__c, 
                Term__c, TradeInLineItems__c, TradeIn_Entitlement__c, X2ndBankOfLink__c, X3rdBankOfLink__c, X4thBankOfLink__c 
                , EmailCC__c, HubEmail__c, HubName__c
            FROM Quote_Tool_Drafts__c
            WHERE Id = :recordId];
        
        Quote_Tool_Drafts__c newRec = originalRec.clone(false, true, false, false);
        newRec.Status__c = 'Draft';
        newRec.Opportunity__c = newOppId;

        insert newRec;
        return newRec.Id;
    }

    private static Map<String, Object> GetPredefinedPicklists(List<String> picklistNames) {
        List<QuoteFormPicklist__mdt> picklists = [
            SELECT Id, Label__c, DeveloperName
            FROM QuoteFormPicklist__mdt
            WHERE DeveloperName IN :picklistNames];

        List<QuoteFormPicklistValue__mdt> pickValues = [
            SELECT Id, DisplayLabel__c, Item_Name__c, IsActive__c, QuoteFormPicklist__c, IsDefault__c, Index__c
            FROM QuoteFormPicklistValue__mdt
            WHERE QuoteFormPicklist__c IN :picklists
            ORDER BY QuoteFormPicklist__c, Index__c NULLS FIRST, DisplayLabel__c];

        Map<Id, List<QuoteFormPicklistValue__mdt>> pickValByPicklistId = new Map<Id, List<QuoteFormPicklistValue__mdt>>();
        for (QuoteFormPicklistValue__mdt pickVal :pickValues) {
            if (!pickValByPicklistId.containsKey(pickVal.QuoteFormPicklist__c))
                pickValByPicklistId.put(pickVal.QuoteFormPicklist__c, new List<QuoteFormPicklistValue__mdt>());

            pickValByPicklistId.get(pickVal.QuoteFormPicklist__c).add(pickVal);
        }

        Map<String, Object> result = new Map<String, Object>();

        for (QuoteFormPicklist__mdt pickList :picklists) {
            Map<String, Object> resPicklist = new Map<String, Object> {
                'Label' => pickList.Label__c,
                'DeveloperName' => pickList.DeveloperName };

            if (pickValByPicklistId.containsKey(pickList.Id)) {
                List<Object> resPickVal = new List<Object>();
                for (QuoteFormPicklistValue__mdt pickListVal :pickValByPicklistId.get(pickList.Id)) 
                    resPickVal.add(new Map<String,Object> {
                        'label' => pickListVal.DisplayLabel__c,
                        'value' => pickListVal.Item_Name__c,
                        'defaultValue' => pickListVal.IsDefault__c,
                        'active' => pickListVal.IsActive__c });                

                resPicklist.put('picklistValues', resPickVal);
            }

            result.put(pickList.DeveloperName, resPicklist);
        }

        system.debug(JSON.serialize(result));
        return result;
    }

    private static Map<String, Object> GetBasedOnPicklists(List<String> fieldNames) {
        Map<string, Set<String>> fieldByObjectName = new Map<string, Set<String>>();
        for (String name :fieldNames) {
            string objName = name.substring(0, name.indexOf('.'));
            string fieldName = name.substring(name.indexOf('.') + 1);

            if (!fieldByObjectName.containsKey(objName))
                fieldByObjectName.put(objName, new Set<String>());

            fieldByObjectName.get(objName).add(fieldName);  
        }

        Map<String, Object> result = new Map<String, Object>();

            
        if (fieldByObjectName.size() > 0) {
            List<Schema.DescribeSobjectResult> objDesc = Schema.describeSObjects(
                new List<String>(fieldByObjectName.keySet()));

            Map<String, Schema.DescribeSobjectResult> objMap = new Map<String, Schema.DescribeSobjectResult>();
            
            for(Schema.DescribeSobjectResult res :objDesc) 
                objMap.put(res.getName(), res);

            for (string objName :objMap.keySet()) {
                Map<string, Schema.SObjectField> objFields = objMap.get(objName).fields.getMap();
                for (String field :fieldByObjectName.get(objName)) {
                    Schema.SObjectField objField = objFields.get(field);
                    if (objField != null) 
                        result.put(objName + '.' + field, GetFieldInfo(objField));            
                }
            }
        }

        system.debug(JSON.serialize(result));        
        return result;
    }

/*
    public static Map<String, Object> GetFieldsProperties(string objectName, List<String> fieldNames) {    
        Map<String, Object> result = new Map<String, Object>();
        Schema.DescribeSobjectResult objDesc = Schema.describeSObjects(new string[] { objectName })[0];
        system.debug(new Object[] {'Object', objDesc});

        for (String fieldName :fieldNames) {
            Schema.SObjectField objField = objDesc.fields.getMap().get(fieldName);
            Object record = GetFieldInfo(objField);
            if (record) result.put(objectName + '.' + fieldName, record);                
            else result.put(objectName + '.' + fieldName, 'not found');                
        }

        return result;
    } */

    private static List<Map<String, Object>> GetFieldInfo(Schema.SObjectField objField) {
        // Field not found
        if (objField == null) return null; //throw new NoAccessException();

        DescribeFieldResult fieldProps = objField.getDescribe();

        // User has Access to this field
        // if (!fieldProps.isAccessible()) throw new NoAccessException();
        
        system.debug(new Object[] {'objField', objField});

        //return objField;
        List<Map<String, Object>> pickValues = new List<Map<String, Object>>();
        for (PicklistEntry pe :fieldProps.getPicklistValues()) {
            pickValues.add(new Map<String, Object> {
                'label' => pe.getLabel(),  
                'name' => pe.getValue(),  
                'active' => pe.IsActive(),  
                'defaultValue' => pe.IsDefaultValue()
            });
        }

        return pickValues;
    }    
}