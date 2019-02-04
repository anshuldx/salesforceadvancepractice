global class LicenseAvail implements Schedulable {

public String result;
public String orgName;
public String orgCountry;

global void execute(SchedulableContext ctx){

 //Get Organization to get content of company info details
         Organization orgDetails =[ select Id, Name, Country from Organization limit 1];
            Id orgId = orgDetails.Id;
            orgName = orgDetails.Name;
            orgCountry = orgDetails.Country;

        PageReference pr=new PageReference('/'+orgId);
        //called screenscraping: get the data from the page
        String rawData=pr.getContent().toString();

    //locate a particular element within the raw data
    //the info after this line contains the active license count
    String licRow = '>Salesforce</th><td class=" dataCell  ">Active</td><td class=" dataCell  numericalColumn">';
    Integer licLen = licRow.length();
    System.debug('******************** licLen: ' + licLen);
    Integer pos=rawData.indexOf(licRow);

if (-1!=pos)
{
         Integer licStart = pos + licLen;
         result=rawData.substring(licStart, licStart+3);
         System.debug('***************** SubString: ' + result);
  }

//get used licenses and determine if count of available is 5 or less

Decimal lic = decimal.valueOf(result);

integer u = [select count() from user where profile.UserLicense.Name = 'salesforce' and isactive = true];

 Decimal userCount = decimal.valueOf(u);

Integer totalUnused = (lic.intValue() - userCount.intValue());
System.debug('************ Licenses???? ***************** ' + String.valueOf(totalUnused));
    if(totalUnused <= 5) {

   System.debug('Sending Email...');
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAdd = new String[]{'email@address.com'};
   mail.setToAddresses(toAdd);
   mail.setReplyTo('email@address.com');
   mail.setSenderDisplayName('Salesforce License Notification');
   mail.setSubject(orgName + ' License Count: ' + String.valueOf(totalUnused));
   mail.setBccSender(false);
   mail.setUseSignature(false);
   mail.setPlainTextBody('License Count: ' + String.valueOf(totalUnused));
   mail.setHtmlBody('License Availability Alert:<br/>' + orgName + ', '+ orgCountry + '<br/>' + 'License Count: ' + String.valueOf(totalUnused));
   List<Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.Email[] { mail });
   System.debug('****************** Email Sent: '+results.get(0).isSuccess() );
}

}
}