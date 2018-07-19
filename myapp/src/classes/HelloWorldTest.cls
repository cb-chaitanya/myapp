@IsTest
public class HelloWorldTest
{
    @IsTest(SeeAllData = true)
     public static void test1() 
     {
         HelloWorld ch = new HelloWorld();
         ch.str='world hello';
         
     
     }
}