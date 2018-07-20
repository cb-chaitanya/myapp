public class BillWrapper
{
    public ch_test__Bill__c b{get;set;}
    public String str{get;set;}
    public BillWrapper()
    {
        str='';
        b=new ch_test__Bill__c();
    }

}