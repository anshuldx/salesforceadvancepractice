//Abstract class to create different type of apex charts
public abstract class Chart{
    //public List<PieWedgeData> pieDataSource{get;set;}
    //public List<PieWedgeData> pieDataDivision{get;set;}
    
    /*public Chart(){
        pieDataSource= new List<PieWedgeData>();
        pieDataDivision= new List<PieWedgeData>();
    }*/
    
    public static List <PieWedgeData> drawPieChart_LeadSource(List <AggregateResult> leadsBySourceResult) {
        List<PieWedgeData> pieDataSource= new List<PieWedgeData>();
        for(AggregateResult aggObj: leadsBySourceResult ){
            String leadSource= String.valueOf(aggObj.get('LeadSource'));
            Integer quantity= Integer.valueOf(aggObj.get('Quantity'));
            //if(leadSource==NULL)
                //pieDataSource.add(new PieWedgeData('Other', quantity));    
            if(leadSource!=NULL)
                pieDataSource.add(new PieWedgeData(leadSource, quantity));
        }
        System.debug('@@@@@@@data@@@'+pieDataSource);
        return pieDataSource;
       
    }
    
    public  static List <PieWedgeData> drawPieChart_LeadDivision(List <AggregateResult> leadsByDivisionResult ) {
        List<PieWedgeData> pieDataDivision= new List<PieWedgeData>();
        System.debug('####drawPieChart_LeadDivision() called');
        for(AggregateResult aggObj: leadsByDivisionResult ){
            String leadSource= String.valueOf(aggObj.get('BusinessDivision__c'));
            Integer quantity= Integer.valueOf(aggObj.get('Quantity'));
            
                   
            if(leadSource!=NULL)
                pieDataDivision.add(new PieWedgeData(leadSource, quantity));
        }
        System.debug('@@@@@@@data@@@'+pieDataDivision);
        return pieDataDivision;
    }

}