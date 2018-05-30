/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        TestObectFactory is used as a central repository where records, required for testing,
		can be created easily. In case newly required fields are added to objects, this class
		should be one single place where the field can be added, instead of adjusting all 
		test classes creating this record by itself.

    Test Class: N.A.		
    Pages: N.A.
    History:
        Initial creation 2018/05/01

*/
@isTest
public class TestObjectFactory {
    
    private static TestUserAccess userAccess = null;
    
    // method used to create account records
    public static Account CreateAccount(string name) {
        return new Account(
            Name = name); /*,
            Actual_Quarterly_Number_of_Calls__c = 0,
            Actual_Quarterly_Number_of_Meetings__c = 0); */
    }
    
    // method used to create sub account records
    public static Account CreateAccount(string name, Id parentId) {
        return new Account(
            Name = name,
        	ParentId = parentId); /*,
            Actual_Quarterly_Number_of_Calls__c = 0,
            Actual_Quarterly_Number_of_Meetings__c = 0); */
    }

    // method used to create contact records
	public static Contact CreateContact(string firstName, string lastName, Id accountId) {
        return new Contact(
            AccountId = accountId,
            LastName = lastName,
  			FirstName = firstName);
    }
    
    // method used to create task records
	public static Task CreateTask(string subject, string type, Id whatId, Id whoId, Date activityDate) {
        return new Task(
        	Subject = subject,
        	WhoId = whoId,
        	WhatId = whatId,
        	Type = type,
        	ActivityDate = activityDate);
    }
    
    
    // method used to create opportunity records
    public static Opportunity CreateNewOpportunity(Id accountId, string name) {
        Opportunity result = new Opportunity(
            AccountId = accountId,
            CloseDate = system.today().addMonths(1),
            StageName = 'Forecast',
            Name = name);
        
        return result;
    }
    
    public static Quote_Tool_Drafts__c CreateNewQuoteToolDrafts(Id opportunityId) {
        Quote_Tool_Drafts__c result = new Quote_Tool_Drafts__c(
            Opportunity__c = opportunityId,
            //Contents__c = 'This is a test',
            //QuoteLineItems__c = 'This is a test',
            Pricing__c = 0,
            TradeIn_Entitlement__c = 'Entitlement',
            Submission_Date__c = system.today().addMonths(1));
        
        return result;
    }

    public static Customer_Preference__c createCustomerPreference(string accountId) {
        return createCustomerPreference(accountId, 'Outright');
    }

    public static Customer_Preference__c createCustomerPreference(string accountId, string modelName) {
        return new Customer_Preference__c(
            Model__c = modelName, 
            Account__c = accountId);
    }

	// method used to create new user records
    public static User CreateNewUser(string tempName, string profileName, string roleName) {            
        if (TestObjectFactory.userAccess == null)
            TestObjectFactory.userAccess = new TestUserAccess();
        
        User result = TestObjectFactory.userAccess.CreateNewUser(tempName, profileName, roleName);
        return result;
    }
     
    // method used to create Lead records    
    public static Lead CreateNewLead(String lastName, String companyName) {
        return new Lead(firstName = 'firstName', LastName = lastName, Company = companyName);
    }

    public static Product2 createProduct(string name) {
        return new Product2(Name = name, IsActive = true, Family = 'EGM', ProductCode = 'p01');
    }

    public static List<Product2> createProductList() {
        List<Map<String, String>> productDefs = new List<Map<String, String>> {
			new Map<String, String> { 'Name' => 'Product A', 'ProductCode' => 'A', 'Description' => 'Description of product', 'Family' => 'EGM' },
			new Map<String, String> { 'Name' => 'Product B', 'ProductCode' => 'B', 'Description' => 'Description of product', 'Family' => 'EGM' },
			new Map<String, String> { 'Name' => 'Product C', 'ProductCode' => 'C', 'Description' => 'Description of product', 'Family' => 'EGM' },
			new Map<String, String> { 'Name' => 'Product D', 'ProductCode' => 'D', 'Description' => 'Description of product', 'Family' => 'Conversions' },
			new Map<String, String> { 'Name' => 'Product E', 'ProductCode' => 'E', 'Description' => 'Description of product', 'Family' => 'Conversions' },
			new Map<String, String> { 'Name' => 'Product F', 'ProductCode' => 'F', 'Description' => 'Description of product', 'Family' => 'Conversions' },
			new Map<String, String> { 'Name' => 'Product 1', 'ProductCode' => '1', 'Description' => 'Description of product', 'Family' => null },
			new Map<String, String> { 'Name' => 'Product 2', 'ProductCode' => '2', 'Description' => 'Description of product', 'Family' => null },
			new Map<String, String> { 'Name' => 'Product 3', 'ProductCode' => '3', 'Description' => 'Description of product', 'Family' => null }
		};

        List<Product2> result = new List<Product2>();
        for (Map<String, String> item :productDefs) {
            result.add(new Product2(
                Name = item.get('Name'), 
                IsActive = true, 
                Description = item.get('Description'),
                Family = item.get('Family'), 
                ProductCode = item.get('ProductCode')));
        }

        return result;  
    }

    public static PriceBook2 createPriceBook(String name) {
        if (name == null) name = 'Custom Pricebook';
        return new Pricebook2(Name = name, isActive = true);
    }

    public static List<PricebookEntry> createPricebookEntries(List<Product2> products, Id pricebookId) {
        List<PricebookEntry> result = new List<PricebookEntry>();

        for (Product2 item :products) {
            result.add(new PricebookEntry(
                Pricebook2Id = pricebookId,
                Product2Id = item.Id,
                UseStandardPrice = false,
                UnitPrice = 12000, 
                IsActive = true));
        }

        return result;
    }

    /*
     * Get user, previously created, by tempName
     */ 
    public static User getUser(string tempName) {
        if (TestObjectFactory.userAccess == null)
            throw new TestException('Create a user first!');
        
        return TestObjectFactory.userAccess.getUser(tempName);
    }
    
    /*
     * Class that contains the logic for the actual test
     */ 
    public static String whoIs(User user) {
        if (TestObjectFactory.userAccess == null)
            throw new TestException('Create a user first!');
        
        return TestObjectFactory.userAccess.whoIs(user);
    }    
    
    /*
     * Class that populates users for tests
     */ 
    public class TestUserAccess {
    	// map for profiles
        Map<String, Profile> profiles;
        // map used for roles
        Map<String, UserRole> roles;
        // map used for permissionsets
        Map<String, PermissionSet> permissions;
        // make sure the usernames are unique
        Integer userCount = 1;
        // map for users
        public Map<String, User> userList { get; private set; }
        
        /*
         * Constructor for class
         * Gather all information required during the process
         * */
        public TestUserAccess() {
            userList = new Map<String, User>();
            
            List<Profile> profs = [
                SELECT Id, Name, UserLicense.Name
                FROM Profile WHERE UserLicense.Name = 'Salesforce' AND Name LIKE 'ATI%'];
            
            List<UserRole> rls = [
                SELECT Id, Name FROM UserRole];
            
            List<PermissionSet> perms = [
                SELECT Id, Name, Label FROM PermissionSet];
            
            this.profiles = new Map<String, Profile>();
            for (Profile prof :profs) this.profiles.put(prof.Name, prof);
            
            this.roles = new Map<String, UserRole>();
            for (UserRole rol :rls) this.roles.put(rol.Name, rol);
            
            this.permissions = new Map<String, PermissionSet>();
            for (PermissionSet perm :perms) this.permissions.put(perm.Label, perm);
        }
        
        public List<User> CreateNewUsers(List<UserDefinition> userDefs) {
            List<User> users = new List<User>();
            for (UserDefinition usrDef :userDefs) {
                usrDef.User = CreateNewUser(usrDef.Name, usrDef.ProfileName, usrDef.RoleName);
                users.add(usrDef.User);
            }
            
            insert users;
            
            List<PermissionSetAssignment> psas = new List<PermissionSetAssignment>();
            
            for (UserDefinition usrDef :userDefs) {
                for (String pName :usrDef.PermissionSetNames) {
                    
                    Id permissionSetId = permissions.get(pName).Id;                    
                    psas.add(new PermissionSetAssignment(
                        PermissionSetId = permissionSetId,
                        AssigneeId = usrDef.User.Id));  
                }            	
            }
            
            if (psas.size() > 0) 
                insert psas;
            
            return users;
        }
        
        /*
         * Create a new user with given name, profile and role
         * */
        public User CreateNewUser(string localName, string profileName, string roleName) {            
            if(!Test.isRunningTest())  throw new TestException('User this script only for testing purposes!');
            if (!profiles.containsKey(profileName)) throw new TestException('Profile: "' + profileName + '" not found!');
            if (!roles.containsKey(roleName) && roleName != null) 
                throw new TestException('Role: "' + roleName + '" not found!');
            
            Profile profile = this.profiles.get(profileName);
            UserRole role = roleName != null ? this.roles.get(roleName) : null;            
            
            this.userCount++;
            string lastName = profile.Name + ' Test: '+ (role != null ? role.Name.left(4) : 'no role assigned');
            if (lastName.length() > 80) lastName = lastName.left(80);
            
            User result = new User(
                Username = 'test.tool.user.' + this.userCount + '@aristorcrat.com.citest', 
                FirstName = localName,
                Lastname = lastName, 
                Alias = 'Alias', 
                Email = 'paul.perry@example.com',
                CommunityNickname = 'ccnictst' + this.userCount, 
                TimeZoneSidKey = 'America/Los_Angeles', 
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8', 
                ProfileId = profile.Id,                
                LanguageLocaleKey = 'en_US');  
            
            if (role != null) result.UserRoleId = role.Id;
            
            this.userList.put(localName, result);
            return result;
        }
        
        public void AssignPermissionSets(Map<String, Set<Id>> userIdsByPermissionSetName) {
            List<PermissionSetAssignment> psas = new List<PermissionSetAssignment>();
            for (String pName :userIdsByPermissionSetName.keySet()) {
                if (!permissions.containsKey(pName)) 
                    throw new TestException('Permissionset "' + pName + '" not found!');
                Id permissionSetId = permissions.get(pName).Id;
                for (Id userId :userIdsByPermissionSetName.get(pName))
            		psas.add(new PermissionSetAssignment(
                        PermissionSetId = permissionSetId,
	                	AssigneeId = userId));            	
            }
            
            insert psas; 
        }
        /*
         * Select a user by username
         * */
        public User getUser(string name) {
            if (!this.userList.containsKey(name))
                throw new TestException('User named "' + name + '" not found!');
            
            return this.userList.get(name);
        }
        
        /*
         * Get user information by user instance
         * */
        public String whoIs(User user) {
            string result = '';
            User usr = null;
            
            for (String usrName :this.userList.keySet()) {
                if (user.Id == this.userList.get(usrName).Id) {
                    usr = this.userList.get(usrName);
                    result = usrName + ' ';
                    break;
                }
            }
            
            if (usr == null) return 'Unknown';
            
            for (Profile pr :this.profiles.values())
                if (pr.Id == usr.ProfileId) {
                    result += 'Profile: ' + pr.Name + ' / ';
                    break;
                }
            
            for (UserRole ur :this.roles.values())
                if (ur.Id == usr.UserRoleId) {
                    result += 'User Role: ' + ur.Name;
                    break;
                }
            
            return result;
        }
    }
    
    /*
     * Exception class, used for custom exceptions
     */
	public class TestException extends Exception {}  
    
    public class UserDefinition {
        public String Name {get;set;}
        public String ProfileName {get;set;}
        public String RoleName {get;set;}
        public Set<String> PermissionSetNames {get;set;}
        
        public User User {get;private set;}
        
        public UserDefinition(String name, String profileName, String roleName, Set<String> permissionSetNames) {
            this.Name = name;
            this.ProfileName = profileName;
            this.RoleName = roleName;
            this.PermissionSetNames = permissionSetNames;
        }
    }       
}