global class LeadProcessor implements Database.Batchable<sObject> 
{
   global Database.QueryLocator start(Database.BatchableContext bc) 
   {
       return Database.getQueryLocator('SELECT ID, LeadSource FROM Lead');
   }
   
   global void execute(Database.BatchableContext bc, List<Lead> scope)
   {
       //List<Lead> leadLst = new List<Lead>();
       for(Lead ld : scope)
       {
           ld.LeadSource = 'Dreamforce';
       }
       if(scope.size() > 0) update scope;
   }
   
   global void finish(Database.BatchableContext bc){}
}