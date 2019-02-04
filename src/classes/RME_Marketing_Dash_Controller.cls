//This controller created for displaying lead source and business division with respective counts
public class RME_Marketing_Dash_Controller extends Chart {
    
    //Getter-Setters
    public String datename { get; set; }
    public integer MyLeadCounter{get;set;}  //keeps track of the offset
    public integer list_size{get;set;} //sets the page size or number of rows
    public integer MyLeadtotal_size{get;set;}
    public List <AggregateResult> leadsBySourceResult {get;set;}
    public List <AggregateResult> leadsByDivisionResult {get;set;}
    public List<SelectOption> timerangelist{get;set;}
    public string selectedTimeframe{get;set;}
    public List <PieWedgeData> pieDataSource {get;set;}
    public List <PieWedgeData> pieDataDivision{get;set;}
    public string Objectidentifier {get;set;}
    
    //Constructor
    public RME_Marketing_Dash_Controller (){
        MyLeadCounter=0;
        list_size=10;
        //myleads=new List <lead>([select id,name,Company,LeadSource,BusinessDivision__c,Status,CreatedDate from lead where Chk_loggedinUser__c=1]);
        MyLeadtotal_size=[select id,name,Company,LeadSource,BusinessDivision__c,Status,CreatedDate from lead where Chk_loggedinUser__c=1].size();
        leadsBySourceResult = new List <AggregateResult>([select LeadSource,count(id) Quantity from lead where Chk_loggedinUser__c=1 group by LeadSource]);
        leadsByDivisionResult = new List <AggregateResult>([select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 group by BusinessDivision__c]);
        //Create Graph
        pieDataSource= new List <PieWedgeData>();
        pieDataDivision=new List <PieWedgeData>();
        pieDataSource=Chart.drawPieChart_LeadSource(leadsBySourceResult );
        pieDataDivision=Chart.drawPieChart_LeadDivision(leadsByDivisionResult);
        //drawPieChart_LeadSource();
        //drawPieChart_LeadDivision();
        
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
    
   
    public void showLeadsinTimeFrame(){
        leadsBySourceResult =Database.query('select LeadSource,count(id) Quantity from lead  where Chk_loggedinUser__c=1 AND CreatedDate='+selectedTimeframe+' group by LeadSource');
        leadsByDivisionResult = Database.query('select BusinessDivision__c,count(id) Quantity from lead where Chk_loggedinUser__c=1 AND CreatedDate='+selectedTimeframe+' group by BusinessDivision__c'); 
       
        //Create Graph
        pieDataSource= new List <PieWedgeData>();
        pieDataDivision=new List <PieWedgeData>();
        pieDataSource=Chart.drawPieChart_LeadSource(leadsBySourceResult);
        pieDataDivision=Chart.drawPieChart_LeadDivision(leadsByDivisionResult);
        
    }
    
    
     //Get all leads for the context user
    public List <Lead> getmyleads(){
        System.debug('********Getter of My Leads called*********');
        List <lead> tempMyLeadsList=new List <lead>([select id,name,Company,LeadSource,BusinessDivision__c,Status,CreatedDate from lead where Chk_loggedinUser__c=1 limit:list_size offset:MyLeadCounter]);    
        return tempMyLeadsList;
    }
    public PageReference Beginning() { //user clicked beginning in pagination section
      System.debug('@@@@@@Objectidentifier@@@@@'+Objectidentifier);
      if(Objectidentifier.equalsIgnorecase('MyLead')){
        MyLeadCounter= 0; 
      }
      return null;
   }
 
   public PageReference Previous() { //user clicked previous button in pagination section
      System.debug('@@@@@@Objectidentifier@@@@@'+Objectidentifier);
      if(Objectidentifier.equalsIgnorecase('MyLead')){
        MyLeadCounter-= list_size;
      }
      
      
      return null;
   }
 
   public PageReference Next() { //user clicked next button in pagination section
      System.debug('@@@@@@Objectidentifier@@@@@'+Objectidentifier);
      if(Objectidentifier.equalsIgnorecase('MyLead')){
        MyLeadCounter+= list_size;
      }
      return null;
   }
 
   public PageReference End() { //user clicked end in pagination section
      System.debug('@@@@@@Objectidentifier@@@@@'+Objectidentifier); 
      if(Objectidentifier.equalsIgnorecase('MyLead')){
        MyLeadCounter= MyLeadtotal_size- math.mod(MyLeadtotal_size, list_size)-list_size; 
      }
      return null; 
   }
   public Integer getLeadPageNumber() { //used in pagination
      return MyLeadCounter/list_size+ 1;
   }
 
   public Integer getLeadTotalPages() { //used in pagination
      if (math.mod(MyLeadtotal_size, list_size) > 0) {
         return MyLeadtotal_size/list_size + 1;
      } else {
         return (MyLeadtotal_size/list_size);
      }
   }
   public Integer getLeadRecordsFrom() { //used in pagination
      integer leadPageNumber = getLeadPageNumber();
      
      return (leadPageNumber-1)*list_size+1;
   }
   public Integer getLeadRecordsTo() {   //used in pagination  
      integer leadPageNumber = getLeadPageNumber();      
      integer leadTotalPages = getLeadTotalPages();
      if(leadPageNumber < leadTotalPages )   
        return (leadPageNumber-1)*list_size+list_size;
      else
        return MyLeadtotal_size;
   }
   
    
}