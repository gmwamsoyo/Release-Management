@IsTest
private class LeadProcessorTest
{
   @testSetup 
   static void setup() {
        List<Lead> leadLst = new List<Lead>();
        for(integer i = 1; i <= 200; i++)
        {
            leadLst.add(New Lead(Company = 'Test Company', Firstname = 'Firstname ' + i, Lastname = 'Lastname ' + i));
        }
        insert leadLst;
    }
    
    static testmethod void test() 
    {        
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}