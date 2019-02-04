<aura:application >
	
	

    <aura:attribute name="label" type="string" required="false"/>
    <aura:attribute name="value" type="decimal" required="true"/>
    	
       <ui:button label="{!v.label}" />
       <c:meter value="{!v.value}" />  
 





</aura:application>