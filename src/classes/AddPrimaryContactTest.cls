@IsTest
private class AddPrimaryContactTest
{
    @TestSetup
    static void setup()
    {
        List<Account> NYAcctLst = new List<Account>();
        for(integer i = 1; i <= 50; i++)
        {
            NYAcctLst.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY'));
        }
        insert NYAcctLst;
        
        List<Account> CAAcctLst = new List<Account>();
        for(integer i = 1; i <= 50; i++)
        {
            CAAcctLst.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA'));
        }
        insert CAAcctLst;
    }
    
    static testmethod void test()
    {
        Contact primCont = new Contact(Firstname = 'Firstname', Lastname = 'Lastname');
        AddPrimaryContact addContact = new AddPrimaryContact(primCont, 'CA');
        Test.startTest();    
          System.enqueueJob(addContact);
        Test.stopTest();
        System.AssertEquals(50, [select count() from Contact where Account.BillingState = 'CA']);
    }
}