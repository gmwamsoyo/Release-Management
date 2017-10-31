@IsTest
private class AccountManagerTest{

    @isTest static void testGetAccount() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://na39.salesforce.com/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test Account', thisAccount.Name);
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