@isTest
public class LookupCtrlTest {
    public static testMethod void testGetRecentItems() {
        List<String> objNames = new List<String> {
            'Account', 'Contact', 'User', 'ListView'
        };
        
        Object obj = LookupCtrl.GetRecentItems(objNames);
        
        system.debug(JSON.serialize(obj));

    }
}