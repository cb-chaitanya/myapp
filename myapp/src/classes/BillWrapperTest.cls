@IsTest
public class BillWrapperTest
{
    @IsTest(SeeAllData = true)
     public static void test1() 
     {
         BillWrapper ch = new BillWrapper();
         ch.str='world hello';
         ch_test__Bill__c b=ch.b;
     
     }
}