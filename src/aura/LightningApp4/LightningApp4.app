<aura:application >
	<aura:attribute name="console" type="String"/>
		
			<button onclick="{!c.handleClick}">
             Label HTML Button
		</button>
        <hr/>

		<ui:button label="Label Lightning ui:button" press="{!c.handleClick}"/>

		<hr/>

		<h1> Console Output: </h1>
		<ui:OutputTextArea value="{!v.console}"/> 
		

</aura:application>