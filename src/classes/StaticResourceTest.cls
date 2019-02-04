@isTest
public class StaticResourceTest {

      static testmethod void staticResourceLoad(){
        
        //Load CSV file saved in static resource  
        List<SObject> accountsList= Test.loadData(Account.sObjectType,'LoadAccounts');
        List<SObject> contactsList= Test.loadData(Contact.sObjectType,'LoadContacts');
        
        //Confirm that total number of accounts created are 5
        System.assertEquals(accountsList.size(), 5);
        
        for(Account a : [SELECT Id, Name, (SELECT FirstName,LastName FROM Contacts) FROM Account where Id IN :accountsList ]){
            //confirm that every Account has associated child contact
            system.debug('#####a.id####:'+a.id);
            System.assertNotEquals(null, a.contacts);
            
            //confirm that every Account has exactly 2 contacts
            System.assertEquals(a.contacts.size(), 2);
        }
        /*List<Contact> contactsToUpdate = new List<Contact>();*/

        for (Integer i = 0; i < contactsList.size(); i++) {
            Contact currentContact = (Contact) contactsList[i];
            //currentContact.AccountId = (Id) accountsList[i].Id;
            //contactsToUpdate.add(currentContact);
            system.debug('@@@@currentContact.accountid@@@@:'+currentContact );
        }
        /*update(contactsToUpdate);*/

        // Check that the Contact is listed to the right Account
        /*Integer i = 0;
        for (Contact con : [SELECT Id, AccountId FROM Contact WHERE Id IN :contactsToUpdate]) {
            System.debug('\R\N\R\N\R\N\R CONTACT ACCOUNT ID:' + con.AccountId + '\R\N\R\N\R\N\R');
            System.assertEquals(accountsList[i].Id, con.AccountId);
            i++;
        }*/
    }
}