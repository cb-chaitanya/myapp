public with sharing class CustomPopupController {

    public boolean showPopup {get;set;}
    public String pname{get;set;}
    public List<String> names{get;set;}
    
    public CustomPopupController ()
    {
        showPopup = false;
        names = new List<String>{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o'};
        pname = 'Add_charge';
    }
    public PageReference addCharge()
    {
        showPopup = true;
        pname = 'Add_charge';
        return null;
    }
    public PageReference test1()
    {
        showPopup = true;
        pname = 'test1';
        return null;
    }
    public PageReference test2()
    {
        showPopup = true;
        pname = 'test2';
        return null;
    }
    
    public PageReference openPopup()
    {
        showPopup = true;
        return null;
    }
    
    public PageReference Cancel()
    {
        showPopup = false;
        return null;
    }
    

}