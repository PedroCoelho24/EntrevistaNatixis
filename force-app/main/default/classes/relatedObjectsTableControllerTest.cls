@isTest
private class relatedObjectsTableControllerTest {
    @isTest
    static void testListOfRelatedObjects() {
        // Test data setup
        Object_A__c testObjectA = new Object_A__c(Name = 'Test Object A');
        insert testObjectA;
        
        Object_B__c testObjectB = new Object_B__c(Name = 'Test Object B', Object_A__c = testObjectA.Id);
        insert testObjectB;
        
        Object_C__c testObjectC = new Object_C__c(Name = 'Test Object C', Object_B__c = testObjectB.Id);
        insert testObjectC;
        
        // Call the method being tested
        List<relatedObjectsTableController.objectWrapper> result = relatedObjectsTableController.listOfRelatedObjects(testObjectA.Id);
        
        // Verify the results
        System.assertEquals(2, result.size(), 'Expected two related objects');
        System.assertEquals(testObjectB.Id, result[0].objectId, 'Unexpected Object B Id');
        System.assertEquals(testObjectB.Name, result[0].name, 'Unexpected Object B Name');
        System.assertEquals(testObjectC.Id, result[1].objectId, 'Unexpected Object C Id');
        System.assertEquals(testObjectC.Name, result[1].name, 'Unexpected Object C Name');
    }
}