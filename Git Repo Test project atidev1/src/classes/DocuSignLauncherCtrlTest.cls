/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        PoC For DocuSign integration. As Javascript within buttons is not supported
		for Lightning Pages, a custom button opening a link could be a solution
    
		This is a test class for Lightning Component named DocuSignLauncher its controller
    
	Test Class: (current)
    Pages: N.A.
    History:
        Initial creation 2018/04/24

*/

@isTest
public class DocuSignLauncherCtrlTest {

    // Verify if the controller returns a list of contacts related to given account
    public static testMethod void RunTest() {
        Account acc = new Account(Name = 'ABC - XYZ');
        insert acc;
        
        Contact cnt = new Contact(
            AccountId = acc.Id,
            FirstName = 'firstname',
            Lastname = 'lastname');
        
        insert cnt;
        
        test.startTest();
        Object x = DocuSignLauncherCtrl.GetContactList(acc.Id);
        test.stopTest();
        system.assert(x != null);        
    }   
}