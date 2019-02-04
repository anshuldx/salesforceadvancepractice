({    
    handleShowModal: function(component, evt, helper) {
        var modalBody;
        var description = component.get("v.description");
        $A.createComponent("c:modalContent", {"description": description},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   modalBody = content;
                                   component.find('overlayLib').showCustomModal({
                                       header: "Application Confirmation",
                                       body: modalBody, 
                                       showCloseButton: true,
                                       cssClass: "mymodal",
                                       closeCallback: function() {
                                           alert('You closed the alert!');
                                       }
                                   })
                                   
                               }
                               
                           });
    }
})