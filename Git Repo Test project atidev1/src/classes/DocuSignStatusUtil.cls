/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		Once signed, the output PDF doc is uploaded as an attachment related to a 
		DocuSignStatus record. The record should be visible by Role hierarchy and
		also, in case the record is owned by a Sales Manager, being shared with 
		the user's team members as well. The logic for this is handled in the 
		method below. 
	
	Test Class: DocuSignStatusUtilTest
	Pages: N.A.
	History:
		Required for Sprint #6
		Initial creation 2018/04/30

*/
public class DocuSignStatusUtil {
    /*
     * DocuSignStatus is used by docusign to keep track of signing status,
     * but it's also used to store signed PDF documents. Its OWD sharing
     * setting is set to private with access through hierarchy. One 
     * exception is that Sales managers (sitting in the lowest branche
     * in the Role hierarchy) should see documents from their team members
     * sharing the same role. That's what this code snipped is used for.
     * 
     * - In case the owners' role has no child roles, it's considered a 
     * 	 Sales Manager. The record will be shared with a public group
     *   for its Role.
     * - If the owners' role does have child roles, nothing happens and
     *   no sharing settings are applied.
     */ 
    public static void ShareRecords(List<dsfs__DocuSign_Status__c> newList) {
        // container for sharing records, to be inserted
		List<dsfs__DocuSign_Status__Share> statusShares  = new List<dsfs__DocuSign_Status__Share>();

        Set<Id> 
            userIds = new Set<Id>(),
            roleIds = new Set<Id>();
        
        for(dsfs__DocuSign_Status__c status :newList) 
            userIds.add(status.ownerId);
        
        // obtain all roles from users within the current context
        Map<Id,User> users = new Map<Id,User>([
        	SELECT Id, UserRoleId
        	FROM User 
        	WHERE Id IN :userIds]);
        
        for (User usr :users.values()) 
            if (usr.UserRoleId != null) 
            	roleIds.add(usr.UserRoleId);
        
        // fetch all existing roles including reference to their parent roles
		Map<Id,UserRole> roles = new Map<Id,UserRole>([
            SELECT Id, Name, ParentRoleId
        	FROM UserRole]);
        
        // track all the roles containing children
        Set<Id> rolesWithChilds = new Set<Id>();
        for (UserRole role :roles.values())
            rolesWithChilds.add(role.ParentRoleId);
        
        // Isolate roles that aren't parents
        for (Id roleId :rolesWithChilds)
            roles.remove(roleId);
        
        // Get all related Public Group records 
        List<Group> groups = [
            SELECT Id, Name, DeveloperName, RelatedId, Email, OwnerId 
            FROM Group 
            WHERE RelatedId IN :roles.keySet()];

        // Create Map of GroupIds by RoleIds 
        Map<Id,Id> groupIdByRelatedId = new Map<Id,Id>();
        for (Group grp :groups)
            groupIdByRelatedId.put(grp.RelatedId, grp.Id);

        // For each of the dsfs__DocuSign_Status records being processed
        for(dsfs__DocuSign_Status__c status :newList) {
            // Get the status' owners roleId
            String roleId = users.get(status.OwnerId).UserRoleId;
            // Exclude records from sharing in case their role doesn't 
            // sit down the hierarchy or the user has no role assigned
            if (roleId == null || rolesWithChilds.contains(roleId)) continue;
            
            // Find the roleIds' related groupId
            String groupId = groupIdByRelatedId.get(roleId);
                                    
            // Create a new dsfs__DocuSign_Status__Share record with access accordingly.
            dsfs__DocuSign_Status__Share statusShare = new dsfs__DocuSign_Status__Share(
            	ParentId = status.Id,
            	UserOrGroupId = groupId,
            	AccessLevel = 'Read');
                        
            // Add to the list to be inserted once ready
            statusShares.add(statusShare);
        }
        
        // Insert all of the newly created Share records and commit to system 
        if (statusShares.size() > 0)
        	Database.SaveResult[] statusSharesInsertResult = Database.insert(statusShares, false);         
    }
}