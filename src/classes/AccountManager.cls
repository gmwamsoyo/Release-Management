@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager
{    
    @HttpGet
    global static Account getAccount()
    {
        RestRequest request = RestContext.request;
        String[] accountIdLst = request.requestURI.split('/');
        if(accountIdLst.size() < 2) return null;
        string accountId = accountIdLst[accountIdLst.size() - 2]; 
        return [select Id, Name, (select Id, Name from Contacts)
                from Account
                where Id = :accountId];
    }
}