({
	goThere: function(component,event, helper){
        var caseId = component.get("v.paramB");
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": caseId.substring(0, 15)
        });
        navEvt.fire();
    }
})