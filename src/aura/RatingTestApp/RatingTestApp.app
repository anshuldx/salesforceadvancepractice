<aura:application >

    
      
       
    <div class="c-container">
        <lightning:layout multipleRows="true">
            <lightning:layoutItem padding="around-small" size="12">
                <div class="page-section page-header">
                    <h2>Rate your Experience</h2>
                </div>
            </lightning:layoutItem>
            <lightning:layoutItem padding="around-small" size="12">
                <lightning:layout>
                    <lightning:layoutItem padding="around-small" size="3">
                        <div class="page-section page-right">
                            <h2>Left Sidebar</h2>
                            <p>Usability:
                    <c:Rating change="{!c.presentationRatingChange}"/>	
                </p>
                <p>Data Quality:
                    <c:Rating change="{!c.knowledgeRatingChange}" colorOn="#00A1E0" colorOff="#EEEEEE"/>	
                </p>    
                <p>Business Process:
                    <c:Rating change="{!c.organizationRatingChange}" colorOn="#64E000" stroke="#000000" strokeWidth="3"/>
                </p>
                <lightning:textarea name="feedbackDescription" label="Description:" placeholder="type here..." title="Please describe your experience"/>
                        </div>
                    </lightning:layoutItem>
                    
                </lightning:layout>
            </lightning:layoutItem>
            <lightning:layoutItem flexibility="auto" padding="around-small" size="12">
                <div class="page-footer page-section">
                    <h2><lightning:button label="Save"/></h2>
                </div>
            </lightning:layoutItem>
        </lightning:layout>
    </div>
            
      
      
</aura:application>