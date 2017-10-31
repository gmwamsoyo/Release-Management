@RestResource(urlMapping='/Order/*')
global with sharing class OrderResource {

class OrderLineUpd
    {
        public string Id { get; set; }
        public double CurrentNet { get; set; }
        public double Discount { get; set; }
        public integer JobsQty { get; set; }
        public integer UsersQty { get; set; }
    }

  @HttpDelete
  global static void doDelete() {
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
     Account account = [SELECT Id FROM Account WHERE Id = :accountId];
     delete account;
  }
  @HttpGet
  global static LIST<Order__C> doGet() {
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
     LIST<Order__C> result = [SELECT BillingFrequency__r.BillingFrequencyID__c, BillingFrequency__r.Name, comment__c, ContractExists__c, CreditCardID__c,CurrentNet__c, Customer__r.CustName__c, Discount__c, IsEmailInvoice__c,            
                                     FunctionalCurrency__r.Name, FunctionalCurrency__r.CurrencyCode__c, IsNewOrder__c, IsRecurringOrder__c, OrderNbr__c, OrderStatus__c, ReportingCurrency__r.Name, ReportingCurrency__r.CurrencyCode__c,   
                                    ServiceCancelDate__c, ServiceEndDate__c, ServiceStartDate__c, SoldByPartnerNbr__c, 
                                   (SELECT BillingFrequency__r.BillingFrequencyID__c, BillingFrequency__r.Name, CurrentNet__c, Discount__c, FunctionalCurrency__r.Name, FunctionalCurrency__r.CurrencyCode__c, 
                       JobsQty__c, LineNum__c, Market__c, ReportingCurrency__r.Name, ReportingCurrency__r.CurrencyCode__c, ServiceEndDate__c, ServiceStart__c, Status__c, ThirtyDayUpg__c, 
                       UsersQty__c, WebsiteName__c, WebstoreUpg__c 
                    FROM Order_Lines__r)
                              FROM Order__c];
   return result;
  }
  @HttpPost
   global static String doPost() {
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string jsonBody = req.requestBody.toString();
     OrderLineUpd orderLineUpd  = (OrderLineUpd)JSON.deserialize(jsonBody, OrderResource.OrderLineUpd.class);
     OrderLine__c orderLine = [SELECT CurrentNet__c, Discount__c, JobsQty__c, UsersQty__c FROM OrderLine__c WHERE Id = :orderLineUpd.Id];
     orderLine.CurrentNet__c = orderLineUpd.CurrentNet;
     orderLine.Discount__c = orderLineUpd.Discount;
     orderLine.JobsQty__c = orderLineUpd.JobsQty;
     orderLine.UsersQty__c = orderLineUpd.UsersQty;
     update orderLine;

   return orderLineUpd.Id;
  }
}