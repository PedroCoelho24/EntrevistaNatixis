public class relatedObjectsTableController {
    
    @AuraEnabled
    public static List<objectWrapper> listOfRelatedObjects(String recordId) {
        try {
            List<Object_B__c> listOfObjectsB = [SELECT Id, Name FROM Object_B__c WHERE Object_A__c = :recordId LIMIT 5000];
            List<Object_C__c> listOfObjectsC = [SELECT Id, Name FROM Object_C__c WHERE Object_B__r.Object_A__c = :recordId LIMIT 5000];
            List<objectWrapper> listOfResults = new List<objectWrapper>();
            for(Object_B__c objB : listOfObjectsB)
            {
                listOfResults.add(new objectWrapper(objB.Id, objB.Name));
            }
            for(Object_C__c objC : listOfObjectsC)
            {
                listOfResults.add(new objectWrapper(objC.Id, objC.Name));
            }
            return listOfResults;
        } catch (Exception e) {
            throw new applicationException(e);
        }
    }
    
    public class objectWrapper {
        @AuraEnabled
        public String objectId {get; set;}
        @AuraEnabled
        public String name {get; set;}
        
        public objectWrapper(String objectId, String name) {
            this.objectId = objectId;
            this.name = name;
        }
    }

    public class applicationException extends Exception {}

}