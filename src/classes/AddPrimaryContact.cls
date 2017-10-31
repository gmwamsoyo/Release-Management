public class AddPrimaryContact implements Queueable 
{
    Contact cont;
    String stateCode;
    public AddPrimaryContact(Contact cont, String stateCode)
    {
        this.cont = cont;
        this.stateCode = stateCode;
    }
    
    public void execute(QueueableContext context) 
    {
        List<Contact> contactLst = new List<Contact>();
        for(Account acct : [select Id from Account where BillingState = :stateCode limit 200])
        {
            Contact clonedCont = cont.Clone();
            clonedCont.AccountId = acct.Id;
            contactLst.add(clonedCont);
        }
        if(contactLst.size() > 0) insert contactLst; 
    }
}