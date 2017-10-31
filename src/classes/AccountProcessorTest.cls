@IsTest
private class AccountProcessorTest {

  @IsTest
  private static void testContactCount() {
    Test.startTest();
    List<Id> acctIdLst = new List<Id>();
    acctIdLst.add(createTestRecord());
    AccountProcessor.countContacts(acctIdLst);
    Test.stopTest();
    List<Account> acctlst = [select Number_of_Contacts__c from Account where Id IN :acctIdLst];
    System.assertEquals(1, acctlst[0].Number_of_Contacts__c);
  }
  
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            Name = 'Test Account',
            Description = 'New Account');
        insert accountTest;
        insert(new Contact(AccountId = accountTest.Id, Firstname = 'John', Lastname = 'Doe'));
        return accountTest.Id;
    }     
}