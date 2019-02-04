<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Email_to_Contacton_LeadConversion</fullName>
        <description>Send Email to Contacton LeadConversion</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Welcome_Email_for_contact</template>
    </alerts>
    <fieldUpdates>
        <fullName>Fill_Lead_Assignment_Time</fullName>
        <field>Lead_Assigned_Time__c</field>
        <formula>NOW()</formula>
        <name>Fill Lead Assignment Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Initial_Fill_Lead_Assignment_time</fullName>
        <field>Lead_Assigned_Time__c</field>
        <formula>CreatedDate</formula>
        <name>Initial Fill Lead Assignment time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>updatevariable</fullName>
        <field>Approval_Started__c</field>
        <literalValue>0</literalValue>
        <name>updatevariable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>updatevariable2</fullName>
        <field>Approval_Started__c</field>
        <literalValue>0</literalValue>
        <name>updatevariable2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Escalate after 10 days</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Fill Lead Assignment Time</fullName>
        <actions>
            <name>Fill_Lead_Assignment_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED(OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Initial Lead Assignment Time</fullName>
        <actions>
            <name>Initial_Fill_Lead_Assignment_time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Welcome Email Contact</fullName>
        <actions>
            <name>Send_Email_to_Contacton_LeadConversion</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.IsConverted</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Welcome Email Contact</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
