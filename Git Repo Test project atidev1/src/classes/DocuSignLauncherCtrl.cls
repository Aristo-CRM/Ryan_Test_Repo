/* ---------------------------------------------------
    Author:     Paul Perry
    Company:    Sqware Peg
    Description: 
        PoC For DocuSign integration. As Javascript within buttons is not supported
        for Lightning Pages, a custom button opening a link could be a solution
    
        This is a controller for Lightning Component named DocuSignLauncher
    
    Test Class:
    Pages: N.A.
    History:
        Initial creation 2018/04/24

*/

public class DocuSignLauncherCtrl {
    @AuraEnabled
    public static Map<String, Object> GetContactList(Id accountId) { //, Integer offset) {
        //system.debug(new string[] { 'accId: ' + accountId, 'offset: ' + offset });
        Map<String, Object> result = new Map<String, Object>();
        List<Contact> contacts = [
            SELECT Id, Email, Name
            FROM Contact
            WHERE AccountId = :accountId
            ORDER BY LastName
            LIMIT 50]; 
            // OFFSET :offset];
                
        // ToDo: 
        //   - Get available templates from DocuSign or make configurable using custom setting
        //   - show/hide templates based on region (US / ANZ)
        //   
        List<Object> templates = new List<Object> {
            new Map<String, String> { 
                'Id' => '3959e77b-0f73-4b95-83a7-d0ac173de289',
                'Name' => 'NZ - Application for credit account' },
            new Map<String, String> { 
                'Id' => 'd1e498f4-9aa8-4941-94e9-57df7ae4cb67',
                'Name' => 'US - Application for credit account (Spanish version)' }
        };

        result.put('Contacts', contacts);
        result.put('Templates', templates);

        return result;
    }
}