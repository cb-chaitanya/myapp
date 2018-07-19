@IsTest
public class AddChargeTest 
{
     @IsTest(SeeAllData = true)
     public static void test1() 
     {
         PageReference pageRef = Page.Add_Charge;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('sub_id','1mk51ePQSZ5k7VILl');
         pageRef.getParameters().put('pk','0032800001KlI0J');
         AddCharge ch = new AddCharge();
         ch.opts = 'ADD_UNBILLED_CHARGE';
         ch.Amount = '1000';
         ch.Description = 'test';
         //ch.save();
     
     }
     
    @IsTest(SeeAllData = true)
     public static void test2() 
     {
         PageReference pageRef = Page.Add_Charge;
         test.setCurrentPageReference(pageRef);
         pageRef.getParameters().put('sub_id','1mk51ePQSZ5k7VILl');
         pageRef.getParameters().put('pk','0032800001KlI0J');
         AddCharge ch = new AddCharge();
         ch.opts = 'INVOICE_NOW';
         ch.Amount = '1000';
         ch.Description = 'test';
         //ch.save();
     
     }     
 }