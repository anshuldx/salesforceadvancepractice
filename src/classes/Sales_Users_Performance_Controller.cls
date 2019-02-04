////This controller counts the performance of Sales users based on the counts of Lead,Account,Contact,opportunity
public class Sales_Users_Performance_Controller {
     //Variables
     public map <string,integer> userWithLeadsCount=new map <string,integer> ();
     public map <string,integer> userWithAccountsCount=new map <string,integer> ();
     public map <string,integer> userWithContactsCount=new map <string,integer> ();
     public map <string,integer> userWithOppsCount=new map <string,integer> ();
     
     public List <AggregateResult> Leadsbyuser=new List <AggregateResult> (); 
     public List <AggregateResult> Accountsbyuser=new List <AggregateResult> (); 
     public List <AggregateResult> Contactsbyuser=new List <AggregateResult> ();
     public List <AggregateResult> Oppsbyuser=new List <AggregateResult> ();
    
    //Getter-Setters
    public List <wrapCountsWithUser> wrapCountsWithUserList {get;set;} 
     
     public List<SelectOption> timerangelist{get;set;}
     public string selectedTimeframe{get;set;}
     
    //Constructor
    public Sales_Users_Performance_Controller(){
        wrapCountsWithUserList = new List <wrapCountsWithUser>();
        Leadsbyuser = new List <AggregateResult>([select ownerID,count(id) Quantity from Lead group by ownerid]);
        Accountsbyuser = new List <AggregateResult>([select ownerID,count(id) Quantity from Lead where (convertedAccountID!=NULL AND isconverted=true) group by ownerID]);
        Contactsbyuser = new List <AggregateResult>([select ownerID,count(id) Quantity from Lead where (convertedContactID!=NULL AND isconverted=true) group by ownerID]);
        Oppsbyuser = new List <AggregateResult>([select ownerID,count(id) Quantity from Lead where (convertedopportunityId!=Null AND isconverted=true) group by ownerID]);
        
        //Prepare map of counting No. of Lead respective to sales person
        for(AggregateResult aggObj: Leadsbyuser ){
            userWithLeadsCount.put(String.valueOf(aggObj.get('ownerID')),Integer.valueOf(aggObj.get('Quantity')) );
              
        }
        
        //Prepare map of counting No. of Account respective to sales person
        for(AggregateResult aggObj: Accountsbyuser ){
            userWithAccountsCount.put(String.valueOf(aggObj.get('ownerID')),Integer.valueOf(aggObj.get('Quantity')) );    
            //if(Integer.valueOf(aggObj.get('Quantity'))==) 
                //userWithAccountsCount.put(String.valueOf(aggObj.get('ownerID')),0);        
        }
        
        //Prepare map of counting No. of Contact respective to sales person
        for(AggregateResult aggObj: Contactsbyuser){
            userWithContactsCount.put(String.valueOf(aggObj.get('ownerID')),Integer.valueOf(aggObj.get('Quantity')) );    
        }
        
        //Prepare map of counting No. of Opportunity respective to sales person
        for(AggregateResult aggObj: Oppsbyuser ){
            userWithOppsCount.put(String.valueOf(aggObj.get('ownerID')),Integer.valueOf(aggObj.get('Quantity')) );    
        }
        
        //Put all maps data into wrapper List
        for(User userObj: [select id,name from user where UserType='Standard']){
                        
            System.debug('$$$'+userWithAccountsCount.containsKey(userObj.id));
            //if(userObj.name!='' && (userWithAccountsCount.containsKey(userObj.id)) && (userWithContactsCount.containsKey(userObj.id))&& (userWithoppsCount.containsKey(userObj.id))&& (!userWithLeadsCount.containsKey(userObj.id))){
                //wrapCountsWithUserList.add(new wrapCountsWithUser(userObj.name,0,userWithAccountsCount.get(userObj.id),userWithContactsCount.get(userObj.id),userWithOppsCount.get(userObj.id)));    
            //}
            //if( (userWithAccountsCount.containsKey(userObj.id)==false) && (userWithContactsCount.containsKey(userObj.id)==true)&& (userWithoppsCount.containsKey(userObj.id)==true)&& (userWithLeadsCount.containsKey(userObj.id)==true)){
               // wrapCountsWithUserList.add(new wrapCountsWithUser(userObj.name,userWithLeadsCount.get(userObj.id),0,userWithContactsCount.get(userObj.id),userWithOppsCount.get(userObj.id)));    
            //}
            
            //if(userObj.name!='' && (userWithAccountsCount.containsKey(userObj.id)) && (!userWithContactsCount.containsKey(userObj.id))&& (userWithoppsCount.containsKey(userObj.id))&& (userWithLeadsCount.containsKey(userObj.id))){
               // wrapCountsWithUserList.add(new wrapCountsWithUser(userObj.name,userWithLeadsCount.get(userObj.id),userWithAccountsCount.get(userObj.id),0,userWithOppsCount.get(userObj.id)));
            //}
            //if(userObj.name!='' && (userWithAccountsCount.containsKey(userObj.id)) && (userWithContactsCount.containsKey(userObj.id))&& (!userWithoppsCount.containsKey(userObj.id))&& (userWithLeadsCount.containsKey(userObj.id))){
                //wrapCountsWithUserList.add(new wrapCountsWithUser(userObj.name,userWithLeadsCount.get(userObj.id),userWithAccountsCount.get(userObj.id),userWithContactsCount.get(userObj.id),0));    
            //}
            
            //else
                wrapCountsWithUserList.add(new wrapCountsWithUser(userObj.name,userWithLeadsCount.get(userObj.id),userWithAccountsCount.get(userObj.id),userWithContactsCount.get(userObj.id),userWithOppsCount.get(userObj.id)));
            
        }
        
        //Create Timeframe Picklist Values
        timerangelist= new List<SelectOption> ();
        timerangelist.add(new SelectOption('--Select Time Frame----','--Select Time Frame----'));
        timerangelist.add(new SelectOption('TODAY','Today'));
        timerangelist.add(new SelectOption('YESTERDAY','Yesterday'));
        timerangelist.add(new SelectOption('THIS_WEEK','This Week'));
        timerangelist.add(new SelectOption('THIS_MONTH','This Month'));
        timerangelist.add(new SelectOption('THIS_QUARTER','This Quarter'));
        timerangelist.add(new SelectOption('THIS_YEAR','This Year'));
    
    }
    // Wrapper class
    public class wrapCountsWithUser {

        public String name { get; set; }
        public Integer leadCount{ get; set; }
        public Integer accountCount { get; set; }
        public Integer conCount { get; set; }
        public Integer oppCount { get; set; }
        
        /*public wrapCountsWithUser (){
            this.leadCount=0;
            this.accountCount =0;
            this.conCount =0;
            this.oppCount=0;
        }*/
        public wrapCountsWithUser (String name, Integer leadCount ,Integer accountCount ,Integer conCount, Integer oppCount ) {
            this.name = name;
            this.leadCount = leadCount ;
            this.accountCount =accountCount ;
            this.conCount =conCount ;
            this.oppCount =oppCount ;
        }
    }
    public void showLeadsinTimeFrame(){
        System.debug('Entry into showLeadsinTimeFrame()');
        /*if(selectedTimeframe=='TODAY'){
               leadsBySourceResult =new List <AggregateResult>([select LeadSource,count(id) Quantity from lead  where Chk_loggedinUser__c=1 AND CreatedDate=TODAY  group by LeadSource ]);
               leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 AND CreatedDate=TODAY group by BusinessDivision__c]);
        }      
        else if(selectedTimeframe=='YESTERDAY'){
               leadsBySourceResult =new List <AggregateResult>([select LeadSource,count(id) Quantity from lead  where Chk_loggedinUser__c=1 AND CreatedDate=YESTERDAY  group by LeadSource ]);       
               leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 AND CreatedDate=YESTERDAY  group by BusinessDivision__c]);
        }
        else if(selectedTimeframe=='THIS_WEEK'){
               leadsBySourceResult =new List <AggregateResult>([select LeadSource,count(id) Quantity from lead  where Chk_loggedinUser__c=1 AND CreatedDate=THIS_WEEK group by LeadSource ]);              
               leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 AND CreatedDate=THIS_WEEK group by BusinessDivision__c]);
        }
        else if(selectedTimeframe=='THIS_MONTH'){
               leadsBySourceResult =new List <AggregateResult>([select LeadSource,count(id) Quantity from lead  where Chk_loggedinUser__c=1 AND CreatedDate=THIS_MONTH group by LeadSource ]);                     
               leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 AND CreatedDate=THIS_MONTH group by BusinessDivision__c]);
        }
        else if(selectedTimeframe=='THIS_QUARTER'){
               leadsBySourceResult =new List <AggregateResult>([select LeadSource,count(id) Quantity from lead  where Chk_loggedinUser__c=1 AND CreatedDate=THIS_QUARTER group by LeadSource ]);                     
               leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 AND CreatedDate=THIS_QUARTER group by BusinessDivision__c]);
        }
        else if(selectedTimeframe=='THIS_YEAR'){
               leadsBySourceResult =new List <AggregateResult>([select LeadSource,count(id) Quantity from lead  where Chk_loggedinUser__c=1 AND CreatedDate=THIS_YEAR group by LeadSource ]);                     
               leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 AND CreatedDate=THIS_YEAR group by BusinessDivision__c]);
        }
        else{
            leadsBySourceResult = new List <AggregateResult>([select LeadSource,count(id) Quantity from lead where Chk_loggedinUser__c=1 group by LeadSource]);
            leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 group by BusinessDivision__c]);
        }
        //drawPieChart_LeadSource();
        //drawPieChart_LeadDivision();
        */
    }






}