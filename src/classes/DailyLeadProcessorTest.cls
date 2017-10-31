@IsTest
private class DailyLeadProcessorTest
{
    public static String CRON_EXP = '0 0 0 * * ?';
    static testmethod void test()
    {
        List<Lead> leadLst = new List<Lead>();
        for(integer i = 1; i <= 200; i++)
        {
           leadLst.add(new Lead(Firstname = 'firstname' + i, Lastname = 'Lastname' + i, Company = 'Company' + i));
        }
        insert leadLst;
        
        Test.StartTest();
        String jobId = System.schedule('ScheduledLeadProcessorTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.
        List<Lead> lt = [SELECT Id 
            FROM Lead
            WHERE LeadSource != null];
        System.assertEquals(0, lt.size(), 'Dreamforce Lead does not exist before job has run');
        // Stopping the test will run the job synchronously
        Test.stopTest();
        List<Lead> completedLeadLst = [SELECT Id 
            FROM Lead
            WHERE LeadSource = 'Dreamforce'];
         System.assertEquals(200, completedLeadLst.size(), 'DailyLeadProcessor completed successful');
    }
}