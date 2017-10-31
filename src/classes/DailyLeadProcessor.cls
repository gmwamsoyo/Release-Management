global class DailyLeadProcessor implements Schedulable 
{
    global void execute(SchedulableContext ctx) 
    {
        List<Lead> leadLst = new List<Lead>();
        for(Lead ld : [select Id, LeadSource from Lead where leadsource = null limit 200])
        {
            ld.LeadSource = 'Dreamforce';
            leadLst.add(ld);
        }
        if (leadLst.size() > 0) update leadLst;
    }
}