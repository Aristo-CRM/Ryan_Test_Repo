@isTest
private class testAccountHierarchyLightning{
    
    static testMethod void testAccountHierarchy(){
        insert new RunValidationRule__c(Is_Disabled__c = false);

        AccountHierarchyTestDataLightning.createTestHierarchy();

        Account topAccount      = [ Select id, name from account where name = 'HierarchyTest0' limit 1 ];
        Account middleAccount   = [ Select id, parentID, name from account where name = 'HierarchyTest4' limit 1 ];
        Account bottomAccount   = [ Select id, parentID, name from account where name = 'HierarchyTest9' limit 1 ];
        Account[] accountList   = [ Select id, parentID, name from account where name like 'HierarchyTest%' ];

        test.startTest();
        
        // Call Methods for top account
        List<ObjectStructureMap> smt = AccountHierarchyStructure.getObjectStructure(topAccount.id);
        System.Assert( smt.size() > 0, 'Test failed at Top account, no Id' );
        //Call ObjectStructureMap methods
        smt[0].setnodeId( '1234567890' );
        smt[0].setlevelFlag( true );
        smt[0].setlcloseFlag( false );
        smt[0].setnodeType( 'parent' );
        smt[0].setcurrentNode( false );
        smt[0].setaccount( topAccount );
        
        String nodeId       = smt[0].getnodeId();
        Boolean[] levelFlag = smt[0].getlevelFlag();
        Integer level		= smt[0].getLevel();
        Boolean[] closeFlag = smt[0].getcloseFlag();
        String nodeType     = smt[0].getnodeType();
        Boolean currentName = smt[0].getcurrentNode();
        Account smbAccount  = smt[0].getaccount();

        // Call Methods for middle account
        List<ObjectStructureMap> smm = AccountHierarchyStructure.getObjectStructure(middleAccount.id);
        System.Assert( smm.size() > 0, 'Test failed at Middle account, no Id' );

        // Call Methods for bottom account
        List<ObjectStructureMap> smb = AccountHierarchyStructure.getObjectStructure(bottomAccount.id);
        System.Assert( smb.size() > 0, 'Test failed at Bottom account, no Id' );
    
        test.stopTest();
    }
}