public class AddCharge
{

    public AddCharge()
    {
    
        //get current renewal date
    }

   
    public Date d{get;set;}
    public Datetime rd{get;set;}
    public String Amount{get;set;}
    public String Description{get;set;}
    public String opts{get;set;}
    public String MyString_From_Method{get;set;}
    
    public void validateOnServer()
    {
        if(Amount == null || Amount == '' || Description == null || Description == '')
        {
            MyString_From_Method='Error on filled values';
        }
        else if(!(Amount.isNumeric()))
        {
            MyString_From_Method='Invalid Amount';
        }
        else
        {
            MyString_From_Method='Inserted';
        }
        
        System.debug('Amount is '+this.Amount+'.Description is '+this.Description+'.Option is '+this.opts);
    
    }
}