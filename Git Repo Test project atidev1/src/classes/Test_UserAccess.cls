/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		This class is used for testing purposes only. 
		It shows record access by profile / role hierarchy
	
	Test Class: (current)
	Pages: N.A.
	History:
		Initial creation 2018/04/01

	The test has been split up into two different onces to avoid running into limits

	DO NOT DEPLOY THIS TEST CLASS TO PRODUCTION
*/

@isTest
public class Test_UserAccess {
    /*
     * Method used to create temporary users
     * */
    private static TestUserAccess setupUsers(Boolean anz, Boolean us, Boolean vgt, Boolean cfo) {
        TestUserAccess access = new TestUserAccess();
        Map<String, User> userList = new Map<String, User>();

		if (cfo) access.CreateNewUser('CFO', 'ATI CFO', 'Global CFO');
        
        // Setup all the users first
        if (anz) {
            // Creating test user name, profile, role: 'ANZ-MD1', 'ATI Managing Director', 'MD - ANZ'
			access.CreateNewUser('ANZ-MD1', 'ATI Managing Director', 'MD - ANZ');
            // Creating test user name, profile, role: NZ-NSM1', 'ATI ANZ - Sales Managers', 'National Sales Manager - Australia'
            access.CreateNewUser('ANZ-NSM1', 'ATI ANZ - Sales Managers', 'National Sales Manager - Australia');
            // Creating test user name, profile, role: 'ANZ-SSM2', 'ATI ANZ - Sales Managers', 'State Sales Manager - NSW'
            access.CreateNewUser('ANZ-SSM2', 'ATI ANZ - Sales Managers', 'State Sales Manager - NSW');
            // Creating test user name, profile, role: 'ANZ-SM1', 'ATI ANZ - Sales Managers', 'Sales Manager - North'
            access.CreateNewUser('ANZ-SM1', 'ATI ANZ - Sales Managers', 'Sales Manager - North');
            // Creating test user name, profile, role: 'ANZ-BDE1', 'ATI ANZ - Salespeople', 'Sales Team - North NSW'
            access.CreateNewUser('ANZ-BDE1', 'ATI ANZ - Salespeople', 'Sales Team - North NSW');
            // Creating test user name, profile, role: 'ANZ-SM2', 'ATI ANZ - Sales Managers', 'Sales Manager - Metro'
            access.CreateNewUser('ANZ-SM2', 'ATI ANZ - Sales Managers', 'Sales Manager - Metro');
            // Creating test user name, profile, role: 'ANZ-BDE2', 'ATI ANZ - Salespeople', 'Sales Team - Metro'
            access.CreateNewUser('ANZ-BDE2', 'ATI ANZ - Salespeople', 'Sales Team - Metro');
            // Creating test user name, profile, role: 'ANZ-SM3', 'ATI ANZ - Sales Managers', 'Sales Manager - South'
            access.CreateNewUser('ANZ-SM3', 'ATI ANZ - Sales Managers', 'Sales Manager - South');
            // Creating test user name, profile, role: 'ANZ-BDE3', 'ATI ANZ - Salespeople', 'Sales Team - South'
            access.CreateNewUser('ANZ-BDE3', 'ATI ANZ - Salespeople', 'Sales Team - South');
            // Creating test user name, profile, role: 'ANZ-SM4', 'ATI ANZ - Sales Managers', 'Key Accounts Manager - South'
            access.CreateNewUser('ANZ-SM4', 'ATI ANZ - Sales Managers', 'Key Accounts Manager - South');
            // Creating test user name, profile, role: 'ANZ-BDE4', 'ATI ANZ - Salespeople', 'Sales Team - Key Accounts'
            access.CreateNewUser('ANZ-BDE4', 'ATI ANZ - Salespeople', 'Sales Team - Key Accounts');
            // Creating test user name, profile, role: 'ANZ-SSM1', 'ATI ANZ - Sales Managers', 'National Strategic Manager'
            access.CreateNewUser('ANZ-SSM1', 'ATI ANZ - Sales Managers', 'National Strategic Manager');
            // Creating test user name, profile, role: 'ANZ-BDE5', 'ATI ANZ - Salespeople', 'Sales Team - National Strategic'
            access.CreateNewUser('ANZ-BDE5', 'ATI ANZ - Salespeople', 'Sales Team - National Strategic');
            // Creating test user name, profile, role: 'ANZ-SSM3', 'ATI ANZ - Sales Managers', 'State Sales Manager - QLD'
            access.CreateNewUser('ANZ-SSM3', 'ATI ANZ - Sales Managers', 'State Sales Manager - QLD');
            // Creating test user name, profile, role: 'ANZ-BDE6', 'ATI ANZ - Salespeople', 'Sales Team - QLD'
            access.CreateNewUser('ANZ-BDE6', 'ATI ANZ - Salespeople', 'Sales Team - QLD');
            // Creating test user name, profile, role: 'ANZ-SSM4', 'ATI ANZ - Sales Managers', 'State Sales Manager - VIC'
            access.CreateNewUser('ANZ-SSM4', 'ATI ANZ - Sales Managers', 'State Sales Manager - VIC');
            // Creating test user name, profile, role: 'ANZ-BDE7', 'ATI ANZ - Salespeople', 'Sales Team - VIC'
            access.CreateNewUser('ANZ-BDE7', 'ATI ANZ - Salespeople', 'Sales Team - VIC');
            // Creating test user name, profile, role: 'ANZ-SSM5', 'ATI ANZ - Sales Managers', 'State Sales Manager - SA'
            access.CreateNewUser('ANZ-SSM5', 'ATI ANZ - Sales Managers', 'State Sales Manager - SA');
            // Creating test user name, profile, role: 'ANZ-BDE8', 'ATI ANZ - Salespeople', 'Sales Team - SA'
            access.CreateNewUser('ANZ-BDE8', 'ATI ANZ - Salespeople', 'Sales Team - SA');
            // Creating test user name, profile, role: 'ANZ-SD1', 'ATI ANZ - Sales Directors', 'Sales and Operations Director - New Zealand'
            access.CreateNewUser('ANZ-SD1', 'ATI ANZ - Sales Directors', 'Sales and Operations Director - New Zealand');
            // Creating test user name, profile, role: 'ANZ-NSM2', 'ATI ANZ - Sales Managers', 'National Sales Manager - NZ'
            access.CreateNewUser('ANZ-NSM2', 'ATI ANZ - Sales Managers', 'National Sales Manager - NZ');
            // Creating test user name, profile, role: 'ANZ-BDE9', 'ATI ANZ - Salespeople', 'Sales Team - National (NZ)'
            access.CreateNewUser('ANZ-BDE9', 'ATI ANZ - Salespeople', 'Sales Team - National (NZ)');
            // Creating test user name, profile, role: 'ANZ-MC', 'ATI Marketing Communications', 'Marketing - ANZ'
            access.CreateNewUser('ANZ-MC', 'ATI Marketing Communications', 'Marketing - ANZ');
            // Creating test user name, profile, role: 'ANZ-BO', 'ATI Business Operations', 'Business Operations - ANZ'
            access.CreateNewUser('ANZ-BO', 'ATI Business Operations', 'Business Operations - ANZ');
            //accessCreating test user name, profile, role: NZ-Finance1', 'ATI Finance and Accounting', 'Finance - ANZ'
            access.CreateNewUser('ANZ-Finance1', 'ATI Finance and Accounting', 'Finance - ANZ');
            // Creating test user name, profile, role: 'ANZ-Finance2', 'ATI Finance and Accounting', 'Accounting - ANZ'
            access.CreateNewUser('ANZ-Finance2', 'ATI Finance and Accounting', 'Accounting - ANZ');
            // Creating test user name, profile, role: 'ANZ-Credit', 'ATI Credit', 'MD - ANZ'
            access.CreateNewUser('ANZ-Credit', 'ATI Credit', 'MD - ANZ');
            // Creating test user name, profile, role: 'ANZ-Compliance', 'ATI Compliance', 'Compliance - ANZ'
            access.CreateNewUser('ANZ-Compliance', 'ATI Compliance', 'Compliance - ANZ');
            // Creating test user name, profile, role: 'ANZ-Legal', 'ATI Legal', 'Legal - ANZ'
			access.CreateNewUser('ANZ-Legal', 'ATI Legal', 'Legal - ANZ');			
        }
 
        if (us) {
            			// Create new test user: name, profile, role: 'US-MD1', 'ATI Managing Director', 'MD - Americas'
			access.CreateNewUser('US-MD1', 'ATI Managing Director', 'MD - Americas');
            // Create new test user: name, profile, role: 'US-VP1', 'ATI US - Sales Vice Presidents', 'Sales VP - East'
			access.CreateNewUser('US-VP1', 'ATI US - Sales Vice Presidents', 'Sales VP - East');
            // Create new test user: name, profile, role: 'US-SD1', 'ATI US - Sales Directors', 'Sales Director - North'
			access.CreateNewUser('US-SD1', 'ATI US - Sales Directors', 'Sales Director - North');
            // Create new test user: name, profile, role: 'US-BDE1', 'ATI US - Salespeople', 'Sales Team - North'
			access.CreateNewUser('US-BDE1', 'ATI US - Salespeople', 'Sales Team - North');
            // Create new test user: name, profile, role: 'US-SD2', 'ATI US - Sales Directors', 'Sales Director - East'
			access.CreateNewUser('US-SD2', 'ATI US - Sales Directors', 'Sales Director - East');
            // Create new test user: name, profile, role: 'US-BDE2', 'ATI US - Salespeople', 'Sales Team - East'
			access.CreateNewUser('US-BDE2', 'ATI US - Salespeople', 'Sales Team - East');
            // Create new test user: name, profile, role: 'US-SD3', 'ATI US - Sales Directors', 'Sales Director - National'
			access.CreateNewUser('US-SD3', 'ATI US - Sales Directors', 'Sales Director - National');
            // Create new test user: name, profile, role: 'US-BDE3', 'ATI US - Salespeople', 'Sales Team - National (East)'
			// Create new test user: name, profile, role: 'US-BDE3', 'ATI US - Salespeople', 'Sales Team - National (East)'
			access.CreateNewUser('US-BDE3', 'ATI US - Salespeople', 'Sales Team - National (East)');
            // Create new test user: name, profile, role: 'US-VP2', 'ATI US - Sales Vice Presidents', 'Sales VP - West'
			access.CreateNewUser('US-VP2', 'ATI US - Sales Vice Presidents', 'Sales VP - West');
            // Create new test user: name, profile, role: 'US-SD4', 'ATI US - Sales Directors', 'Sales Director - West'
			access.CreateNewUser('US-SD4', 'ATI US - Sales Directors', 'Sales Director - West');
            // Create new test user: name, profile, role: 'US-BDE4', 'ATI US - Salespeople', 'Sales Team - West'
			access.CreateNewUser('US-BDE4', 'ATI US - Salespeople', 'Sales Team - West');
            // Create new test user: name, profile, role: 'US-SD5', 'ATI US - Sales Directors', 'Sales Director - Central'
			access.CreateNewUser('US-SD5', 'ATI US - Sales Directors', 'Sales Director - Central');
            // Create new test user: name, profile, role: 'US-BDE5', 'ATI US - Salespeople', 'Sales Team - Central'
			access.CreateNewUser('US-BDE5', 'ATI US - Salespeople', 'Sales Team - Central');
            // Create new test user: name, profile, role: 'US-SD6', 'ATI US - Sales Directors', 'Sales Director - National (West)'
			access.CreateNewUser('US-SD6', 'ATI US - Sales Directors', 'Sales Director - National (West)');
            // Create new test user: name, profile, role: 'US-VP3', 'ATI US - Sales Vice Presidents', 'Sales VP - LATAM'
			access.CreateNewUser('US-VP3', 'ATI US - Sales Vice Presidents', 'Sales VP - LATAM');
            // Create new test user: name, profile, role: 'US-SD7', 'ATI US - Sales Directors', 'Sales Director - Mexico'
			access.CreateNewUser('US-SD7', 'ATI US - Sales Directors', 'Sales Director - Mexico');
            // Create new test user: name, profile, role: 'US-BDE6', 'ATI US - Salespeople', 'Sales Team - Mexico'
			access.CreateNewUser('US-BDE6', 'ATI US - Salespeople', 'Sales Team - Mexico');
            // Create new test user: name, profile, role: 'US-BDE7', 'ATI US - Salespeople', 'Sales Team - Andes'
			access.CreateNewUser('US-BDE7', 'ATI US - Salespeople', 'Sales Team - Andes');
            // Create new test user: name, profile, role: 'US-SD8', 'ATI US - Sales Directors', 'Sales Director - South America'
			access.CreateNewUser('US-SD8', 'ATI US - Sales Directors', 'Sales Director - South America');
            // Create new test user: name, profile, role: 'US-BDE8', 'ATI US - Salespeople', 'Sales Team - South America'
			access.CreateNewUser('US-BDE8', 'ATI US - Salespeople', 'Sales Team - South America');
            // Create new test user: name, profile, role: 'US-BDE9', 'ATI US - Salespeople', 'Sales Team - Central America'
			access.CreateNewUser('US-BDE9', 'ATI US - Salespeople', 'Sales Team - Central America');
            // Create new test user: name, profile, role: 'US-MC', 'ATI Marketing Communications', 'Marketing - North America'
			access.CreateNewUser('US-MC', 'ATI Marketing Communications', 'Marketing - North America');
            // Create new test user: name, profile, role: 'US-BO', 'ATI Business Operations', 'Business Operations - North America'
			access.CreateNewUser('US-BO', 'ATI Business Operations', 'Business Operations - North America');
            // Create new test user: name, profile, role: 'US-Finance1', 'ATI Finance and Accounting', 'Finance - North America'
			access.CreateNewUser('US-Finance1', 'ATI Finance and Accounting', 'Finance - North America');
            // Create new test user: name, profile, role: 'US-Finance2', 'ATI Finance and Accounting', 'Accounting - North America'
			access.CreateNewUser('US-Finance2', 'ATI Finance and Accounting', 'Accounting - North America');
            // Create new test user: name, profile, role: 'US-Credit', 'ATI Credit', 'Credit - North America'
			access.CreateNewUser('US-Credit', 'ATI Credit', 'Credit - North America');
            // Create new test user: name, profile, role: 'US-Compliance', 'ATI Compliance', 'Compliance - North America'
			access.CreateNewUser('US-Compliance', 'ATI Compliance', 'Compliance - North America');
            // Create new test user: name, profile, role: 'US-Legal', 'ATI Legal', 'Legal - North America'
			access.CreateNewUser('US-Legal', 'ATI Legal', 'Legal - North America');
            // Create new test user: name, profile, role: 'US-VP4', 'ATI US - Sales Vice Presidents', 'President - VGT'
			access.CreateNewUser('US-VP4', 'ATI US - Sales Vice Presidents', 'President - VGT');
            // Create new test user: name, profile, role: 'US-VP5', 'ATI US - Sales Vice Presidents', 'EVP of Sales - VGT'
			access.CreateNewUser('US-VP5', 'ATI US - Sales Vice Presidents', 'EVP of Sales - VGT');
            // Create new test user: name, profile, role: 'US-VP6', 'ATI US - Sales Vice Presidents', 'VP - Midwest (VGT)'
			access.CreateNewUser('US-VP6', 'ATI US - Sales Vice Presidents', 'VP - Midwest (VGT)');
            // Create new test user: name, profile, role: 'US-BDE10', 'ATI US - Salespeople', 'Sales Team - Oklahoma (VGT)'
			access.CreateNewUser('US-BDE10', 'ATI US - Salespeople', 'Sales Team - Oklahoma (VGT)');
            // Create new test user: name, profile, role: 'US-SM1', 'ATI US - Sales Managers', 'Senior Sales Manager - Oklahoma (VGT)'
			access.CreateNewUser('US-SM1', 'ATI US - Sales Managers', 'Senior Sales Manager - Oklahoma (VGT)');
            // Create new test user: name, profile, role: 'US-SM2', 'ATI US - Sales Managers', 'Sales Project Manager (VGT)'
			access.CreateNewUser('US-SM2', 'ATI US - Sales Managers', 'Sales Project Manager (VGT)');
            // Create new test user: name, profile, role: 'US-SM3', 'ATI US - Sales Managers', 'Sales Account Manager (VGT)'
			access.CreateNewUser('US-SM3', 'ATI US - Sales Managers', 'Sales Account Manager (VGT)');
        }
        
        if (vgt) {
            // Create new test user: name, profile, role: 'VGT-MC', 'ATI Marketing Communications', 'Marketing - VGT'
			access.CreateNewUser('VGT-MC', 'ATI Marketing Communications', 'Marketing - VGT');
            // Create new test user: name, profile, role: 'VGT-BO', 'ATI Business Operations', 'Business Operations - VGT'
			access.CreateNewUser('VGT-BO', 'ATI Business Operations', 'Business Operations - VGT');
            // Create new test user: name, profile, role: 'VGT-Finance1', 'ATI Finance and Accounting', 'Finance - VGT'
			access.CreateNewUser('VGT-Finance1', 'ATI Finance and Accounting', 'Finance - VGT');
            // Create new test user: name, profile, role: 'VGT-Finance2', 'ATI Finance and Accounting', 'Accounting - VGT'
			access.CreateNewUser('VGT-Finance2', 'ATI Finance and Accounting', 'Accounting - VGT');
            // Create new test user: name, profile, role: 'VGT-Credit', 'ATI Credit', 'Credit - VGT'
			access.CreateNewUser('VGT-Credit', 'ATI Credit', 'Credit - VGT');
            // Create new test user: name, profile, role: 'VGT-Compliance', 'ATI Compliance', 'Compliance - VGT'
			access.CreateNewUser('VGT-Compliance', 'ATI Compliance', 'Compliance - VGT');
            // Create new test user: name, profile, role: 'VGT-Legal', 'ATI Legal', 'Legal - VGT'
			access.CreateNewUser('VGT-Legal', 'ATI Legal', 'Legal - VGT');
        }

        return access;
    }
    
    /*
     * Run a test for ANZ users only
     * */
    public static testMethod void runTestANZ() {
        // TestUserAccess access = setupUsers(Boolean anz, Boolean us, Boolean vgt, Boolean cfo);
        TestUserAccess access = setupUsers(true, false, false, false);
       
        // Create the prepopulated users in Salesforce
     	insert access.userList.values();
                
        Account myAccount = null;
        Opportunity myOpportunity = null;
        Contact myContact = null;
        
        // Create a test set using  
        User createUser = access.getUser('ANZ-BDE1');
        system.runAs(createUser) {
            system.debug(access.whoIs(createUser));
        	myAccount = access.CreateNewAccount('Test Account / Manager');   
            
            insert myAccount;
            system.debug('Inserted Account:');
            system.debug(myAccount);
                        
            myOpportunity = access.CreateNewOpportunity(myAccount.Id, 'test opp');
            myContact = access.CreateNewContact(myAccount.Id, 'Test', 'Contact');
            
            insert new SObject[] { myOpportunity, myContact };
                
            system.debug('Inserted Opportunity:');
            system.debug(myOpportunity);
            system.debug('Inserted Contact:');
            system.debug(myContact);
        }
                
        test.startTest();
                
        for (string userName :access.userList.keyset()) {
            User usr = access.getUser(userName);
            system.debug (access.whoIs(usr));
            // Impersonate user
            system.runAs(usr) {
                // Try to Edit records from target user perspective
                EditAccountfield(access, myAccount, myOpportunity.Id, myContact.Id) ;
            }
        }                    
              
        test.stopTest();
    }
    
    /*
     * Run a test for US and VGT
     * */
    public static testMethod void runTestUSVGT() {
        // TestUserAccess access = setupUsers(Boolean anz, Boolean us, Boolean vgt, Boolean cfo);
        TestUserAccess access = setupUsers(false, true, false, false);
        access.CreateNewUser('ANZ-BDE1', 'ATI ANZ - Salespeople', 'Sales Team - North NSW');
         
        // Create the prepopulated users in Salesforce
     	insert access.userList.values();
                
        Account myAccount = null;
        Opportunity myOpportunity = null;
        Contact myContact = null;
        
        // Create a test set using  
        User createUser = access.getUser('ANZ-BDE1');
        system.runAs(createUser) {
            system.debug(access.whoIs(createUser));
        	myAccount = access.CreateNewAccount('Test Account / Manager');   
            
            insert myAccount;
            system.debug('Inserted Account:');
            system.debug(myAccount);
                        
            myOpportunity = access.CreateNewOpportunity(myAccount.Id, 'test opp');
            myContact = access.CreateNewContact(myAccount.Id, 'Test', 'Contact');
            
            insert new SObject[] { myOpportunity, myContact };
                
            system.debug('Inserted Opportunity:');
            system.debug(myOpportunity);
            system.debug('Inserted Contact:');
            system.debug(myContact);
        }
                
        test.startTest();
                
        for (string userName :access.userList.keyset()) {
            User usr = access.getUser(userName);
            system.debug (access.whoIs(usr));
            // Impersonate user
            system.runAs(usr) {
                // Try to Edit records from target user perspective
                EditAccountfield(access, myAccount, myOpportunity.Id, myContact.Id) ;
            }
        }                    
              
        test.stopTest();
    }
    
    /* 
     * Verify if the current user is allowed to view/edit Account, Opportunity and Contact records based on their profile / role
     * */
    private static void EditAccountfield (TestUserAccess access, Account account, Id opportunityid, Id contactid) {
        // Sharing Setting: All accounts owned by internal users are shared with all internal users
        system.debug('Reading account is allowed');
        /*
        Account openAccount = account;
        Account openAccount = access.ReadAccount(account.id);
        openAccount.Name = 'New account name';
        */
        account.Name = 'xyz - abc';
		if (access.UpdateRecord(account)) 
            system.debug('Updating account is allowed');
        else
            system.debug('Updating account is not allowed');                
        
        Opportunity openOpportunity = access.ReadOpportunity(opportunityid);
        if (openOpportunity == null) {
            system.debug('Reading opportunity is not allowed');                
        } else {
            system.debug('Reading opportunity is allowed');
            openOpportunity.Name = 'new opp name';
            if (access.UpdateRecord(openOpportunity)) 
                system.debug('Updating opportunity is allowed');
            else
                system.debug('Updating opportunity is not allowed');
        }
        
        Contact openContact = access.ReadContact(contactid);
        if (openContact == null) {
            system.debug('Reading Contact is not allowed');                
        } else {
            system.debug('Reading Contact is allowed');
            openContact.firstName = 'new cont name';
            if (access.UpdateRecord(openContact)) 
                system.debug('Updating Contact is allowed');
            else
                system.debug('Updating Contact is not allowed');
        }       
    } 
    
    /*
     * Class that contains the logic for the actual test
     */ 
    public class TestUserAccess {
    	// map for profiles
        Map<String, Profile> profiles;
        // map used for roles
        Map<String, UserRole> roles;
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
            
            this.profiles = new Map<String, Profile>();
            for (Profile prof :profs) this.profiles.put(prof.Name, prof);
            
            this.roles = new Map<String, UserRole>();
            for (UserRole rol :rls) this.roles.put(rol.Name, rol);
        }
        
        /*
         * Create a new user with given name, profile and role
         * */
        public User CreateNewUser(string localName, string profileName, string roleName) {            
            if(!Test.isRunningTest())  throw new TestException('User this script only for testing purposes!');
            if (!profiles.containsKey(profileName)) throw new TestException('Profile: "' + profileName + '" not found!');
            if (!roles.containsKey(roleName)) throw new TestException('Role: "' + roleName + '" not found!');
            
            Profile profile = this.profiles.get(profileName);
            UserRole role = this.roles.get(roleName);            
            
            this.userCount++;
            
            User result = new User(
                Username = 'test.tool.user.' + this.userCount + '@aristorcrat.com.citest', 
                FirstName = 'Test: '+ role.Name.left(4), 
                Lastname = profile.Name, 
                Alias = 'Alias', 
                Email = 'paul.perry@example.com',
                CommunityNickname = 'ccnictst' + this.userCount, 
                TimeZoneSidKey = 'America/Los_Angeles', 
                LocaleSidKey = 'en_US',
                EmailEncodingKey = 'UTF-8', 
                ProfileId = profile.Id,
                UserRoleId = role.Id,
                LanguageLocaleKey = 'en_US');  
            
            this.userList.put(localName, result);
            return result;
        }
      	
        /*
         * Create a new contact
         * */
        public Contact CreateNewContact(Id accountId, string firstname, string lastname) {
            Contact result = new Contact(
                AccountId = accountId,
                FirstName = firstname,
                Lastname = lastname);
            
            return result;
        }
        
        /*
         * Try to read contact
         * */
        public Contact ReadContact(Id contactId) {
            List<Contact> contacts = [
                SELECT Id, Name 
                FROM Contact
                WHERE Id = :contactId];
            
            if (contacts.size() == 0) return null;
            else return contacts.get(0);
        }    
    /*    
        public Account ReadAccount(Id accountId) {
            List<Account> accounts = [
                SELECT Id, Name 
                FROM Account
                WHERE Id = :accountId];
            
            if (accounts.size() == 0) return null;
            else return accounts.get(0);
        }
    */
        /*
         * Update a record and return wether this is/isn't possible
         */
        public boolean UpdateRecord(SObject theRecord) {
            try {
                update theRecord;
                return true;
            } catch (Exception e) {
                return false;
            }                    
        }
        
        /*
         * Create a new account
         * */
        public Account CreateNewAccount(string name) {
            Account result = new Account(
                Name = name);
            
            return result;
        }    
        
        /*
         * Create a new opportunity
         * */
        public Opportunity CreateNewOpportunity(Id accountId, string name) {
            Opportunity result = new Opportunity(
                AccountId = accountId,
                CloseDate = system.today().addMonths(1),
                StageName = 'Forecast',
                Name = name);
            
            return result;
        }
        
        /*
         * Read an opportunity
         * */
        public Opportunity ReadOpportunity(Id opportunityId) {
            List<Opportunity> opps = [
                SELECT Id, Name 
                FROM Opportunity
                WHERE Id = :opportunityId];
            
            if (opps.size() == 0) return null;
            else return opps.get(0);
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
}