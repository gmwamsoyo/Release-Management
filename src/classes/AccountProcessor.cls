public class AccountProcessor
{
    @future
    public static void countContacts(List<Id> Ids)
    {
        List<Account> acctUpdLst = new List<Account>();
        for(Id accountId : Ids)
        {
           List<Contact> contLst = [select Id from Contact where AccountId = :accountId];
           acctUpdLst.add(new Account(Id = accountId, Number_of_Contacts__c = contLst.size()));
        }      
        if(acctUpdLst.size() > 0) update acctUpdLst;
    }
}