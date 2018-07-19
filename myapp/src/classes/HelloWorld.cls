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
    public void add()
    {
    	System.debug('addition');
    
    }
    public void sub()
    {
    	System.debug('substraction');
    
    }
    public void multiply()
    {
    	System.debug('multiplication');
    
    }

}