public class OpportunityStatusChartController
{
 public List<Tuple> labels {get; set;}
 public List<Tuple> tooltips {get; set;}
 public List<Integer> doneStageNumbers {get; set;}
 public List<Integer> todoStageNumbers {get; set;}
 public Integer labelCount {get; set;}
 public Boolean loadOnce {get; set;}
 public String valsText {get; set;}
        private Opportunity opp;
  
 public OpportunityStatusChartController(ApexPages.StandardController std)
 {
  opp=(Opportunity) std.getRecord();
  loadOnce=true;
 }
  
 public PageReference reload()
 {
  init();
  loadOnce=false;
   
  return null;
 }
  
  
 public void init()
 {
  labels=new List<Tuple>();
  tooltips=new List<Tuple>();
  doneStageNumbers=new List<Integer>();
  todoStageNumbers=new List<Integer>();
   
  labelCount=0;
  Boolean done=false;
  labels.add(new Tuple(labelCount++, '.'));
   
  for (String val : valsText.split(':'))
  {
   if (!done)
   {
    doneStageNumbers.add(labelCount);
   }
   else
   {
    todoStageNumbers.add(labelCount);
   }
     
   if (val==opp.StageName)
   {
    done=true;
    todoStageNumbers.add(labelCount);
   }
   labels.add(new Tuple(labelCount, val));
   toolTips.add(new Tuple(labelCount, 'Help for ' + val + ' stage'));
   labelCount++;
  }  
  labels.add(new Tuple(labelCount, '.'));
 }
  
 public class Tuple 
 {
  public Integer idx {get; set;}
  public String text {get; set;}
   
  public Tuple(Integer inIdx, String inText)
  {
   idx=inIdx;
   text=inText;
  }
 }
}