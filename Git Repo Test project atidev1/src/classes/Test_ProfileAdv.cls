/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		This class is used for testing purposes only. 
		It shows field level security access for specified 
		fields over multiple profiles in a matrix view
	
	Test Class: (current)
	Pages: N.A.
	History:
		Initial creation 2018/04/11

	DO NOT DEPLOY THIS TEST CLASS TO PRODUCTION
*/

@isTest
public class Test_ProfileAdv {
    /* Initial settings */    
    public static boolean VerboseMode = true;
    public static boolean apiFieldNames = true;

    // display names 
	public static string Has_ReadOnlyAccess = 'R';
	public static string Has_ReadWriteAccess = 'RU';
	public static string Has_NoAccess = '-';
	public static string Has_UnknownAccess = '?';
    
    private static List<User> users = null;
    
    // profiles that should be displayed in the results
    private static Set<String> profileNames = new Set<String> {
        'System Administrator', 'ATI ANZ - Sales Directors', 'ATI ANZ - Sales Managers', 
        'ATI ANZ - Sales Vice Presidents', 'ATI ANZ - Salespeople', 'ATI Business Operations', 
        'ATI CFO', 'ATI Compliance', 'ATI Credit', 'ATI Finance and Accounting', 
        'ATI Finance with Contract access', 'ATI Insights', 'ATI Legal', 'ATI Managing Director', 
        'ATI Marketing Communications', 'ATI Marketing VPs', 'ATI Product Marketing', 
        'ATI US - Sales Directors', 'ATI US - Sales Managers', 'ATI US - Sales Vice Presidents', 
        'ATI US - Salespeople'
	};

    // Run the test for account fields
	public static testMethod void RunTestAccounts() {  
		// Provide objectname, profiles and field labels for objects
		String objectName = 'Account';
        // configured fields
		Set<String> fieldLabels = new Set<string> {
                'CurrencyIsoCode',
                'Name',
                'AccountNumber',
                'OwnerId',
                'Site',
                'AccountSource',
                'Actual_Quarterly_Number_of_Calls__c',
                'Actual_Quarterly_Number_of_Meetings__c',
                'Additional_Fee__c',
                'AnnualRevenue',
                'ANZ_LMO__c',
                'AX_ERP_Number__c',
                'Class_2__c',
                'Class_3__c',
                'New_Zealand__c',
                'Compliance_Approval_Email_Address__c',
                'Compliance_Approved__c',
                'CreatedById',
                'Credit_Approval_Email_Address__c',
                'Credit_Approved__c',
                'Credit_Hold__c',
                'Credit_Hold_Reason__c',
                'Customer_AP_Contact__c',
                'Customer_Fiscal_Year_End__c',
                'Customer_Fiscal_Year_Start__c',
                'Customer_Segmentation__c',
                'Jigsaw',
                'Description',
                'Email__c',
                'NumberOfEmployees',
                'Fax',
                'Government_Business_Number__c',
                'Government_Business_Type__c',
                'GP_ERP_Number__c',
                'Hardware_Shipping_Notification__c',
                'Hardware_Shipping_Rules__c',
                'Industry',
                'LastModifiedById',
                'Legal_Entity_Name__c',
                'Legal_Shipping_Term__c',
                'M2K_ERP_Number__c',
                'Number_of_EGMs__c',
                'OperatingHoursId',
                'Ownership',
                'ParentId',
                'Phone',
                'PO_Required__c',
                'Primay_Billing_Address__c',
                'Primary_Billing_Address_Detail__c',
                'Primary_Billing_Address_Map__c',
                'ShippingAddress',
                'Primary_Ship_To_Hardware__c',
                'Primary_Ship_To_Hardware_Map__c',
                'Primary_Ship_To_Software__c',
                'Primary_Ship_To_Software_Details__c',
                'Primary_Ship_To_Software_Map__c',
                'Probity_Status__c',
                'Rating',
                'Region__c',
                'Regulator_ID__c',
                'Regulator_Name__c',
                'Request_Master_Agreement__c',
                'Sales_Region__c',
                'Service_Region__c',
                'Sic',
                'SicDesc',
                'Software_Shipping_City__c',
                'Software_Shipping_Country__c',
                'Software_Shipping_Notification__c',
                'Software_Shipping_Postal_Code__c',
                'Software_Shipping_Rules__c',
                'Software_Shipping_State__c',
                'Software_Shipping_Street__c',
                'Status__c',
                'System_Provider__c',
                'Systems_Region__c',
                'Target_Number_of_Calls__c',
                'Target_Number_of_Visits__c',
                'TickerSymbol',
                'TM1_Number__c',
                'Type__c',
                'Type',
                'BillingAddress',
                'Version_of_System_Provider__c',
                'VLT__c',
                'Washington__c',
                'Website'
			};

        // Run test with given settings
		RunTest(objectName, profileNames, fieldLabels, apiFieldNames);
    }
    
    //Run the test for Lead fields
	public static testMethod void RunTestLeads() {  
		// Provide objectname, profiles and field labels for objects
		String objectName = 'Lead';		
        // configured fields to display
		Set<String> 
			fieldLabels = new Set<string> {
                'Address',
                'AnnualRevenue',
                'Class_2__c',
                'Class_3__c',
                'Company',
                'CreatedById',
                'CurrencyIsoCode',
                'DB_Created_Date_without_Time__c',
                'DB_Lead_Age__c',
                'Description',
                'DoNotCall',
                'EGM_Type__c',
                'Email',
                'Fax',
                'HasOptedOutOfEmail',
                'HasOptedOutOfFax',
                'Industry',
                'Jigsaw',
                'LastModifiedById',
                'LastTransferDate',
                'LeadSource',
                'MobilePhone',
                'Name',
                'New_Zealand__c',
                'Number_of_Gaming_Opps__c',
                'NumberOfEmployees',
                'OwnerId',
                'Phone',
                'Rating',
                'Region__c',
                'Role__c',
                'ShowpadForSF__Showpad_Activity_Count__c',
                'ShowpadForSF__Showpad_Last_Activity_Date__c',
                'ShowpadForSF__Showpad_Last_View_Date__c',
                'ShowpadForSF__Showpad_Last_Viewed_Content__c',
                'ShowpadForSF__Showpad_View_Count__c',
                'Status',
                'System_Provider__c',
                'Title',
                'Total_Number_of_EGMs__c',
                'Total_Number_of_Games_Owned_by_Venue__c',
                'VLT__c',
                'Washington__c',
                'Website'
			};

        // Run test with given settings
		RunTest(objectName, profileNames, fieldLabels, apiFieldNames);
    }    
    
    // Run the test for Contact fields
    public static testMethod void RunTestContact() {  
		// Provide objectname, profiles and field labels for objects
		String objectName = 'Contact';
        
		// configured fields
		Set<String> fieldLabels = new Set<string> {
            'Acceptable_Communication_Channels__c',
            'AccountId',
            'AGE_Customer_Function__c',
            'AGE_Show__c',
            'AHG_Customer_Function__c',
            'AHG_Show__c',
            'Alcohol__c',
            'AssistantName',
            'AssistantPhone',
            'ATI_Newsletter__c',
            'Bespoke_Engagement_Events__c',
            'Bespoke_Product_Launch_Events__c',
            'Birthdate',
            'Canadian_Gaming_Show__c',
            'Canadian_Gaming_Show_Parties__c',
            'Client_Preferred_Communication_Channel__c',
            'CreatedById',
            'CurrencyIsoCode',
            'Customer_requests_follow_up__c',
            'Department',
            'Description',
            'DoNotCall',
            'Early_Adopter_Types__c',
            'EGM_Hardware__c',
            'EGM_Software__c',
            'Email',
            'Fax',
            'Function__c',
            'G2E__c',
            'G2E_Parties__c',
            'Gift__c',
            'Gift_Value_Limit__c',
            'HasOptedOutOfEmail',
            'HasOptedOutOfFax',
            'HomePhone',
            'How_can_Aristocrat_improve_relationship__c',
            'How_satisfied_are_you_with_the_following__c',
            'Jigsaw',
            'LastCURequestDate',
            'LastCUUpdateDate',
            'LastModifiedById',
            'LeadSource',
            'MailingAddress',
            'MobilePhone',
            'Name',
            'NIGA__c',
            'NIGA_Parties__c',
            'NPS_Score__c',
            'NZ_Roadshow__c',
            'OIGA__c',
            'OIGA_Parties__c',
            'OtherAddress',
            'OtherPhone',
            'OwnerId',
            'Phone',
            'Pre_tradeshow_Showroom_Tour__c',
            'Press_Releases__c',
            'Primary_reason_for_your_NPS_score__c',
            'Promotional_Collateral__c',
            'Relationship__c',
            'ReportsToId',
            'Revocation_Notification__c',
            'rh2__Currency_Test__c',
            'rh2__Describe__c',
            'rh2__Formula_Test__c',
            'rh2__Integer_Test__c',
            'Role__c',
            'RSL_Symposium__c',
            'ShowpadForSF__Showpad_Activity_Count__c',
            'ShowpadForSF__Showpad_Last_Activity_Date__c',
            'ShowpadForSF__Showpad_Last_View_Date__c',
            'ShowpadForSF__Showpad_Last_Viewed_Content__c',
            'ShowpadForSF__Showpad_View_Count__c',
            'Status__c',
            'Survey_Response__c',
            'System_Hardware__c',
            'System_Software__c',
            'Systems_Training_Sessions__c',
            'Title',
            'WIGA__c',
            'WIGA_Parties__c',
            'Women_in_Gaming_Events__c'
		};

        // Run test with given settings
        RunTest(objectName, profileNames, fieldLabels, apiFieldNames);
    }  
    
    public static testMethod void RunTestOpportunity() {  
		// Provide objectname, profiles and field labels for objects
		String objectName = 'Opportunity';		
		Set<String> fieldLabels = new Set<string> {
				'AccountId',
                'Amount',
                'At_Risk__c',
                'Bottoms_Up__c',
                'Budget_Confirmed__c',
                'CampaignId',
                'Closed_Lost_Reason__c',
                'CloseDate',
                'Competitor_Name__c',
                'ContractId',
                'Conversion_Type__c',
                'CreatedById',
                'CurrencyIsoCode',
                'Customer_Experience_Cycle__c',
                'Days__c',
                'DB_Competitor__c',
                'Description',
                'Discovery_Completed__c',
                'EGM_Number_of_Units_Plan__c',
                'End_of_Customer_Experience__c',
                'End_of_Sale__c',
                'ExpectedRevenue',
                'Forecast_Amount__c',
                'ForecastCategoryName',
                'IqScore',
                'IsPrivate',
                'Key_Deal__c',
                'LastModifiedById',
                'LeadSource',
                'Name',
                'NextStep',
                'Number_of_Push__c',
                'Number_of_Units_LE__c',
                'Number_of_Units_Plan__c',
                'O_AND_R__c',
                'Other_Reason__c',
                'OwnerId',
                'Parent_Opportunity__c',
                'Pricebook2Id',
                'Probability',
                'Push_Reason__c',
                'Push_Reason_Comments__c',
                'PushCount__c',
                'RecordTypeId',
                'Region__c',
                'ROI_Analysis_Completed__c',
                'Sales_Cycle__c',
                'Sales_Region__c',
                'Saved_Proability__c',
                'Service_Region__c',
                'StageName',
                'Start_of_Customer_Experience__c',
                'Start_of_Sale__c',
                'SyncedQuoteId',
                'Systems_Region__c',
                'TotalOpportunityQuantity',
                'Type'
			};

        // Run test with given settings
        RunTest(objectName, profileNames, fieldLabels, apiFieldNames);
    }  
    
    public static testMethod void RunTestJurisdiction() {  
		// Provide objectname, profiles and field labels for objects
		String objectName = 'Account_Jurisdiction__c';		
		// configured fields
		Set<String> fieldLabels = new Set<string> {
            'Account__c',
            'CreatedById',
            'CurrencyIsoCode',
            'Jurisdiction__c',
            'LastModifiedById',
            'Name'
		};

        // Run test with given settings
        RunTest(objectName, profileNames, fieldLabels, apiFieldNames);
    }
    
    public static testMethod void RunTestAccountTeamMembers() {  
		// Provide objectname, profiles and field labels for objects
		String objectName = 'Account_Team_Member__c';		
		// configured fields
		Set<String> fieldLabels = new Set<string> {
            'Account__c',
            'Account_Team_Member__c',
            'Account_Team_Role__c',
            'CreatedById',
            'CurrencyIsoCode',
            'LastModifiedById',
            'Name',
            'OwnerId'
			};
        
        // Run test with given settings
        RunTest(objectName, profileNames, fieldLabels, apiFieldNames);
    }
    
    // The actual test
    public static void RunTest(string objectName, Set<String> profileNames, Set<string> fieldLabels, Boolean apiFieldNames) {
		Map<Id, Profile> profiles = new Map<Id, Profile>([
			SELECT Id, Name
			FROM Profile
			WHERE Name IN :profileNames]);
        
        if (users == null) {
        	users = CreateUsers(profiles.values());
        	insert users;
    	}
        
		Map<Id, User> testUsers = new Map<Id, User>();
        string displayObjName = '';

		for (User usr :users)
			if (!testUsers.containsKey(usr.ProfileId)) {
				testUsers.put(usr.ProfileId, usr);				
				if (testUsers.size() == profileNames.size()) break;
			}

		Access accessMatrix = new Access();
		List<String> fieldPreview = new List<String>();

		for (User u :testUsers.values())
			System.runAs(u) {
				if (u.Profile.Name == 'System Administrator')
					displayObjName = DetermineAccess(objectName, fieldLabels, apiFieldNames, accessMatrix, fieldPreview);
				else 
                    displayObjName = DetermineAccess(objectName, fieldLabels, apiFieldNames, accessMatrix, null);
			}

		List<String> output = new List<String> { '', '', '', 'Object: ' + objectName }; 
		output.add('Results (copy/paste in Excel-sheet):');
		output.addAll(DisplayValues(displayObjName, objectName, accessMatrix, fieldLabels, profiles));
		output.addAll(new List<String> { '', '', '' });
		
		if (profiles.size() != profileNames.size()) {			
			for (Profile profile :profiles.values())
				profileNames.remove(profile.Name);

			output.add('Unable to find these profile(s), check your spelling (case sensitive):');
			output.add(string.join(new List<String>(profileNames), ', '));
			output.add('');
		}

		if (profiles.size() != testUsers.size()) {
			for (User u :testUsers.values())
				profiles.remove(u.ProfileId);

			List<String> names = new List<String>();
			for (Profile profile :profiles.values())
				names.add(profile.Name);

			output.add('Profile(s) without any user(s) assigned:');
			output.add(string.join(names, ', '));
			output.add('');
		}

		Boolean showAvailableFields = false;
        
        test.startTest();

		if (accessMatrix.fields.size() != fieldLabels.size()) {
			for (AccessContainer field :accessMatrix.fields.values())
				fieldLabels.remove(apiFieldNames ? field.fieldName : field.fieldLabel);

			output.add('Unassigned or unknown field(s), check your spelling (case sensitive):');
			output.add(string.join(new List<String>(fieldLabels), ', '));
			showAvailableFields = true;
		}	

		output.addAll(new List<String> { '', '' });

		if (showAvailableFields && fieldPreview != null) 
			output.addAll(fieldPreview);

		output.addAll(new List<String> { '', '', '' });
		
        system.debug(string.join(output, '\r\n'));	       
		test.stopTest();
	}

	private static String DetermineAccess(String objectName, Set<string> fieldLabels, Boolean apiNames, Access accessMatrix, List<String> output) {
		Id profileId = userinfo.getProfileId();

		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		Schema.SObjectType objType = getObject(schemaMap, objectName, apiNames);

		if (objType == null) return '';

		DescribeSObjectResult obj = objType.getDescribe();
		Map<string, Schema.DescribeFieldResult> fields = getFields(schemaMap, obj);
		List<String> fieldPreviews = new List<String>();
		
		for (Schema.DescribeFieldResult fieldRes :fields.values()) {
			if (!apiNames && fieldLabels.contains(fieldRes.getLabel()) 
				|| (apiNames && fieldLabels.contains(fieldRes.getName()))) {

				accessMatrix.add(profileId, fieldRes);
			}

			if (output != null) 
				fieldPreviews.add(apiNames ? fieldRes.getName() : '\'' + fieldRes.getLabel() + '\'');
		}

		if (output != null) 
			output.add('Available fields (by ' + (apiNames ? 'api name' : 'label') + '):\r\n'
				+ string.join(fieldPreviews, ', '));
        
       	return obj.getLabel();
	}

	private static List<string> DisplayValues(string objectName, string objectApiName, Access accessMatrix, Set<String> fieldLabels, Map<Id, Profile> profiles) {
		List<String> output = new List<String>();

		// Re-enable this section when this issue is resolved:
		//  --> https://success.salesforce.com/issues_view?id=a1p300000008djFAAQ		
		/*
		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		Schema.SObjectType objType = getObject(schemaMap, objectName);
		DescribeSObjectResult obj = objType.getDescribe();

		output.add('');
		output.add('Create\t' + (obj.isCreateable() ? 'yes' : 'no'));
		output.add('Read\t' + (obj.isAccessible() ? 'yes' : 'no'));
		output.add('Update\t' + (obj.isUpdateable() ? 'yes' : 'no'));
		output.add('Delete\t' + (obj.isDeletable() ? 'yes' : 'no'));
		output.add('');
		*/

		String header = 'Field Name';
        
        if (VerboseMode) header = 'Object Name\t' + header + '\tApi Name\tDetails';
		
        for (Id profileId :profiles.keySet()) 
			header += '\t' + profiles.get(profileId).Name;

		output.add(header);
		
		/*
		List<String> fields = new List<String>();
		Map<String, String> fieldNameMap = new Map<String, String>();
		for (AccessContainer field :accessMatrix.fields.values()) {
			fields.add(field.fieldLabel);
			fieldNameMap.put(field.fieldLabel, field.fieldName);
		}

		fields.sort();

		for (String fieldLabel :fields) {
			AccessContainer acField = accessMatrix.fields.get(fieldNameMap.get(fieldLabel)); 
		*/
		for (String fieldLabel :accessMatrix.fields.keySet()) {
			AccessContainer acField = accessMatrix.fields.get(fieldLabel);
			string line = '';
            if (verboseMode) line += objectName;
            line += '\t' + acField.fieldLabel;
            if (verboseMode) line += '\t' + objectApiName + '.' + acField.fieldName + '\t' + acField.metadata;
			
			for (Id profileId :profiles.keySet()) {
				if (acField.profiles.containsKey(profileId))
					line += '\t' + acField.profiles.get(profileId).access;
				else line += '\t' + Has_UnknownAccess;
			}

			output.add(line);
		}

		output.add('');
		output.add('Access Legenda');
		output.add('Read only:\t' + Has_ReadOnlyAccess);
		output.add('Read write:\t' + Has_ReadWriteAccess);
		output.add('No access:\t' + Has_NoAccess);
		output.add('Unable to determine:\t' + Has_UnknownAccess);
		output.add('');

		return output;
	}

	private static Schema.SObjectType getObject(Map<String, Schema.SObjectType> schemaMap, string objectName, Boolean apiName) {
		Set<String> objectNames = new Set<String> { objectName };		

		if (apiName) {
			if (!schemaMap.containsKey(objectName))
				throw new TestException('Error: Object named "' + objectName + '" not found!');		

			return schemaMap.get(objectName);
		}

		for (Schema.SObjectType obj :schemaMap.values()) 
			if (obj.getDescribe().getLabel() == objectName)
				return obj;
        
		string errMsg = 
            'Object ' + (apiName ? 'with API name' : 'labeled') + ' ' 
            + objectName + ' could not be found.\r\n'
			+ 'Please check your spelling (case sensitive)';

		throw new TestException(errMsg);		
	}

	private static Map<string, Schema.DescribeFieldResult> getFields(Map<String, Schema.SObjectType> schemaMap, DescribeSObjectResult obj) {
		Map<string, Schema.DescribeFieldResult> result = new Map<string, Schema.DescribeFieldResult>();
	    Map<String, Schema.SObjectField> fieldMap = schemaMap.get(obj.getName()).getDescribe().fields.getMap();
	    for(Schema.SObjectField sfield : fieldMap.Values()) {
    		Schema.DescribeFieldResult fieldRes = sfield.getDescribe();
			result.put(fieldRes.getLabel(), fieldRes);
		}

		return result;
	}

	public class Access {
		public Map<String, AccessContainer> fields {get;set;}

		public Access() {
			this.fields = new Map<String, AccessContainer>();
		}

		public AccessContainer get(Schema.DescribeFieldResult field) {
			if (!this.fields.containsKey(field.getName()))
				this.fields.put(field.getName(), new AccessContainer());
			
			return this.fields.get(field.getName());
		}

		public void add(Id profileId, Schema.DescribeFieldResult field) {
			this.get(field).add(profileId, field);
		}
	}
    
    private static List<User> CreateUsers(List<Profile> profiles) {
		List<User> result = new List<User>();
        string timestamp = String.valueof(DateTime.now().getTime());
        
        for (Profile profile :profiles)
        	result.add(
                new User(
                    Username = 'test.user.' + (result.size() + 1) + '.' + timestamp + '@aristorcrat.com.devtest', 
                    FirstName = 'Test', 
                    Lastname = profile.Name, 
                    Alias = 'Alias', 
                    Email = 'paul.perry@example.com',
                    CommunityNickname = 'ccnic' + (result.size() + 1) + 'X' + timestamp, 
                    TimeZoneSidKey = 'America/Los_Angeles', 
                    LocaleSidKey = 'en_US',
                    EmailEncodingKey = 'UTF-8', 
                    ProfileId = profile.Id, 
                    LanguageLocaleKey = 'en_US'));     
                
        return result; 
    }
                
    private static String randomString(Integer length) {
    	String sample = 'abcde12345';
		for (Integer cutoff = 10; cutoff <= 1000000; cutoff = cutoff * 10) {
			if (length <= cutoff) return sample.substring(0, length);
			else {
				String newSample = '';
				for (Integer i = 0; i < 10; i ++)
				    newSample += sample;
                
				sample = newSample;
        	}
    	}
        
    	return null;
	}

	public class AccessContainer {
		public String fieldLabel { get; set; }
		public String fieldName { get; set; }
		public String metadata { get; set; }

		public Map<String, AccessFieldContainer> profiles { get; set; }

		public AccessContainer() {
			this.profiles = new Map<String, AccessFieldContainer>();			
		}

		public void Add(Id profileId, Schema.DescribeFieldResult field) {
			string meta = 'Fieldtype: ' + field.getType();
            
            if (field.getType() == Schema.DisplayType.PICKLIST 
			  || field.getType() == Schema.DisplayType.MULTIPICKLIST) {
				List<string> vals = new List<String>();
				for (Schema.PicklistEntry ple :field.getPicklistValues()) 
					if (ple.isActive()) vals.add(ple.getLabel());					
				meta += ' [' + string.join(vals, ';') + ']';
			}
            
            if (field.isCalculated()) meta += ' [IsCalculatedField]';
            if (field.isCustom()) meta += ' [IsCustom]';
            if (!field.isUpdateable()) meta += ' [IsReadOnly]';
            
            this.fieldLabel = field.getLabel();
			this.fieldName = field.getName();
            this.metadata = meta;
            
			this.profiles.put(profileId, new AccessFieldContainer(field));			
		}
	}

	public class AccessFieldContainer {
		public Boolean allowRead { get; set; }
		public Boolean allowUpdate { get; set; }
		
		public String access {
			get {
				if (allowUpdate) return Has_ReadWriteAccess;
				else {
					if (!allowRead) return Has_NoAccess;
					else return Has_ReadOnlyAccess;
				}				 
			}
		}

		public AccessFieldContainer(Schema.DescribeFieldResult field) {
			this.allowRead = field.isAccessible();
			this.allowUpdate = field.isUpdateable();
		}
	}

	public class TestException extends Exception {}
}