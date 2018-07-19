public class ChangeNextRenewalDate
{

    public Date currd{get;set;}
    public String newrd{get;set;}
    public CBURLUtil urlUtil{get;set;}
    public String currRDString{get;set;}
    public String Description{get;set;}
    public String subscriptionId{get;set;}
    public String invoiceOpt{get;set;}
    public List<SelectOption> invoiceOptList{get;set;}
    public boolean prorate{get;set;}
    
    
    //preview related
    public boolean showPopup {get;set;}
    public boolean creditNote{get;set;}
    public boolean invoiceNote{get;set;}
    public String value{get;set;}
    public String key{get;set;}
    public String pname{get;set;}
    public String unitAmount{get;set;}
    public String quantity{get;set;}
    public String descrip{get;set;}
    public String tot{get;set;}
    public String amt{get;set;}
    public List<CreditDetails> cd{get;set;}
    public InvoiceDetails id{get;set;}
    public DateTime newrDT{get;set;}
    
    public ChangeNextRenewalDate()
    {
        subscriptionId = ApexPages.currentPage().getParameters().get('sub_id');
        System.debug('subscriptionId--' + subscriptionId);
        urlUtil = new CBURLUtil(); 
        getCurRenewalDate();
        invoiceOptList = new List<SelectOption>();
        invoiceOptList.add(new SelectOption('ADD_UNBILLED_CHARGE','Add to Unbilled Charges'));                
        invoiceOptList.add(new SelectOption('INVOICE_NOW','Invoice Now'));
        pname='ChangeNextRenewalPreview';
        showPopup=false;
        creditNote=false;
        invoiceNote=false;
        cd = new List<CreditDetails>();
        
    }


    public void getCurRenewalDate()
    {
        subscriptionId = '2smoc98gQflrah01BN5';
        String endPoint = urlUtil.getUrl() + '/api/v2/subscriptions/' + subscriptionId;
        String cbResponse = CBURLUtil.sendRequest(endPoint, null, urlUtil, true);
        System.debug('cbResponse--' + cbResponse);
        String current_term_end = CBURLUtil.getValueFromResponse(cbResponse, 'current_term_end');
        System.debug('current_term_end--' + current_term_end);
        currd = DateTime.newInstance(Long.valueOf(current_term_end)*1000).date();
        System.debug('currd--' + currd);
    }




    public PageReference save()
    {
        subscriptionId = '2smoc98gQflrah01BN5';
        DateTime newrDT;
        long milli;
        System.debug('newrd-- ' + newrd);
        if(newrd!=null){
            newrd += ':00';
        }
        try{
            newrDT = DateTime.newInstance(Integer.valueOf(newrd.subString(0,4)),
                    Integer.valueOf(newrd.subString(5,7)),Integer.valueOf(newrd.subString(8,10)),
                    Integer.valueOf(newrd.subString(11,13)),Integer.valueOf(newrd.subString(14,16)),
                    Integer.valueOf(newrd.subString(17,19)));
        
        
            milli = newrDT.getTime();
            System.debug('sDate--->>' + newrDT);
            System.debug('milli--->>' + milli);
            milli /= 1000;
            //long milli = getUTCDateTime(sDate).getTime();
        }catch(exception e){
            System.debug('Exception---' + e);
        }
        
        String bodyData = '';
        String endpoint = urlUtil.getUrl() + '/api/v2/subscriptions/' + subscriptionId + '/change_term_end_estimate';
        bodyData = CBURLUtil.buildURLString(bodyData, 'term_ends_at', String.valueOf(milli));
        bodyData = CBURLUtil.buildURLString(bodyData, 'prorate', String.valueOf(prorate));
        if( invoiceOpt.equals('INVOICE_NOW')){
            bodyData = CBURLUtil.buildURLString(bodyData, 'invoice_immediately', String.valueOf(true));        
        }
        String cbResponse =  CBURLUtil.sendRequest(endpoint, bodyData, urlUtil, true);
        
        System.debug('cbResponse--'+cbResponse);
        
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('pk'));
    }
    
    
    //preview related code
    public void populate()
    {
        subscriptionId = '2smoc98gQflrah01BN5';
        
        long milli;
        Integer i=0;
        Integer totCount=0;
        System.debug('newrd-- ' + newrd);
        if(newrd!=null){
            newrd += ':00';
        }
        try{
            newrDT = DateTime.newInstance(Integer.valueOf(newrd.subString(0,4)),
                    Integer.valueOf(newrd.subString(5,7)),Integer.valueOf(newrd.subString(8,10)),
                    Integer.valueOf(newrd.subString(11,13)),Integer.valueOf(newrd.subString(14,16)),
                    Integer.valueOf(newrd.subString(17,19)));
        
        
            milli = newrDT.getTime();
            System.debug('sDate--->>' + newrDT);
            System.debug('milli--->>' + milli);
            milli /= 1000;
            //long milli = getUTCDateTime(sDate).getTime();
        }catch(exception e){
            System.debug('Exception---' + e);
        }
        
        String bodyData = '';
        String endpoint = urlUtil.getUrl() + '/api/v2/subscriptions/' + subscriptionId + '/change_term_end_estimate';
        bodyData = CBURLUtil.buildURLString(bodyData, 'term_ends_at', String.valueOf(milli));
        bodyData = CBURLUtil.buildURLString(bodyData, 'prorate', String.valueOf(prorate));
        if( invoiceOpt.equals('INVOICE_NOW')){
            bodyData = CBURLUtil.buildURLString(bodyData, 'invoice_immediately', String.valueOf(true));        
        }
        String cbResponse =  CBURLUtil.sendRequest(endpoint, bodyData, urlUtil, true);
        System.debug('Response--->>' +cbResponse);
        //Parsing
        
        //JSONParser parser = JSON.createParser(cbResponse);
        Integer tot;
        String type;
        Map<String, Object> responseMap = CBURLUtil.convertMap(cbResponse);
        Map<String, Object> estimate = (Map<String, Object>)responseMap.get('estimate');
        List<Object> cnEstimates = (List<Object>)estimate.get('credit_note_estimates');
        if(cnEstimates.isEmpty())
        {
            creditNote = false;
            invoiceNote = true;
            
        }
        else
        {
            creditNote = true;
            invoiceNote = false;
        
        }
        if(creditNote)
        {
            for(Object cnE : cnEstimates)
            {
                tot = (Integer)((Map<String, Object>)cnE).get('total');
                type = (String)((Map<String, Object>)cnE).get('type');
                List<Object> lt = (List<Object>)((Map<String, Object>)cnE).get('line_items');
                CreditDetails cdtemp = new CreditDetails(tot,type);
                for(Object ltE : lt)
                {
                    unitAmount = String.valueOf(((Map<String, Object>)ltE).get('unit_amount'));
                    quantity =   String.valueOf(((Map<String, Object>)ltE).get('quantity'));
                    amt = String.valueOf(((Map<String, Object>)ltE).get('amount'));
                    descrip = String.valueOf(((Map<String, Object>)ltE).get('description'));
                    cdtemp.addLineItems(unitAmount,quantity,descrip,amt);
                
                }
                cd.add(cdtemp);
                System.debug('lt-->>'+lt);
                System.debug('tot-->>'+cdtemp.total);
                System.debug('type-->>'+cdtemp.type);
            
            }
        }
        else
        {
           Map<String, Object> inestimate = (Map<String, Object>)estimate.get('invoice_estimate');
           tot = (Integer)((Map<String, Object>)inestimate).get('total');
           List<Object> lnEstimates = (List<Object>)inestimate.get('line_items');
           id = new InvoiceDetails(tot); 
           for(Object ltE : lnEstimates)
           {
                    unitAmount = String.valueOf(((Map<String, Object>)ltE).get('unit_amount'));
                    quantity =   String.valueOf(((Map<String, Object>)ltE).get('quantity'));
                    amt = String.valueOf(((Map<String, Object>)ltE).get('amount'));
                    descrip = String.valueOf(((Map<String, Object>)ltE).get('description'));   
                    id.addLineItems(unitAmount,quantity,descrip,amt);
           }
        
        
        
        }        
        
        System.debug('creditNote--->>' +creditNote);
        System.debug('invoiceNote--->>' +invoiceNote);

        System.debug('InDetails--->>' +id);
        System.debug('CreditDetails--->>' +cd);
        System.debug('tot--->>' +tot);
        
    
    }
    
    
    public PageReference Cancel()
    {
        showPopup = false;
        return null;
    }
    
    public PageReference preview()
    {
        showPopup = true;
        pname = 'ChangeNextRenewalPreview';
        System.debug('showPopup--' + showPopup);
        System.debug('pname--' + pname);    
        System.debug('Estimate---' + newrd);
        populate();
            
        return null;
    }
    
    
        
     
    public class LineItem
    {
        public String unitAmount{get;set;}
        public String quantity{get;set;}
        public String description{get;set;}
        public String amount{get;set;}
        
        public LineItem(String ua,String quan,String descrip,String amt) 
        {
            unitAmount=ua;
            quantity=quan;
            description=descrip;
            amount=amt;
        }
    
    }
    
    public class CreditDetails
    {
        public List<LineItem> cnl{get;set;}
        public Integer total{get;set;}
        public String type{get;set;}
        
        public CreditDetails(Integer tot,String ty)
        {
            cnl = new List<LineItem>();
            total=tot;
            type=ty;      
        }
        
        public void addLineItems(String ua,String quan,String descrip,String amt)
        {
            LineItem temp = new LineItem(ua,quan,descrip,amt);   
            cnl.add(temp);
        
        }
    
    
    }
    
    public class InvoiceDetails
    {
        public List<LineItem> cnl{get;set;}
        public Integer total{get;set;}
        
        public InvoiceDetails(Integer tot)
        {
            cnl = new List<LineItem>();
            total=tot;      
        }
        
        public void addLineItems(String ua,String quan,String descrip,String amt)
        {
            LineItem temp = new LineItem(ua,quan,descrip,amt);   
            cnl.add(temp);
        
        }
    
    
    }

}