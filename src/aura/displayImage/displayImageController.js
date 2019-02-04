({
     myAction : function(component, event, helper) {
          var speed=component.get("v.interval"); 
          var recordId = component.get("v.recordId");
        var oppt = component.get("c.Image");
        oppt.setParams({
            'parentId': recordId
        });
        oppt.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                  var storeResponse = response.getReturnValue();            
                var count = 0;
                var i = 0;
                if (storeResponse == null) {
                    
                } else {
                    for (i = 0; i < storeResponse.length; i++) {
                        if (storeResponse[i].order < 0)
                            count++;
                    }                   
                    component.set("v.recordId", recordId);
                    component.set("v.atlist", storeResponse);
                    var ids = component.get("v.recordIds");
                    ids.push(recordId);
                    component.set("v.recordIds", ids);               
            }
            }
        });
        $A.enqueueAction(oppt);
          if(speed<500){
            alert("Min Interval 500 Millisecond");
        }else{
         /*   $('.carousel').carousel({
                interval: speed
            });
            $('.carousel').carousel({
                interval: true
            });  */
        }
    },
     Previous : function(component, event, helper) {
        $('#carousel-example-generic').carousel('prev'); 
    },
    Next : function(component, event, helper) {
        $('#carousel-example-generic').carousel('next'); 
        $('#carousel-example-generic').carousel(200);
        
    },

})