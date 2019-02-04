public class displayImage {
 
    @AuraEnabled   
    public static void Image(Id parentId){
       //list<ImagesSlider__c>  
       /*List<ImagesSlider__c> ImgUrlsList=new List<ImagesSlider__c>();
       for(ImagesSlider__c img : [SELECT id,name,(select name,UploadImage__c from Imagess__r)from ImagesSlider__c where id=:parentId]){            
            ImgUrlsList.add(img); 
        }
        system.debug('@@@@'+ImgUrlsList);
          return ImgUrlsList;
       */
           
    }
}