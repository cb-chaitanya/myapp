public class HelloWorld
{
    public String str{get;set;}
    public HelloWorld()
    {
        str = 'Hello World';
    }
    public void print()
    {
    	System.debug('str-->>'+str);
    }

}