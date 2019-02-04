<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>test_email_subject</fullName>
        <description>test email subject</description>
        <protected>false</protected>
        <recipients>
            <recipient>salesforceadvancepractice@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Test_email_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>Set_Next_Step</fullName>
        <description>Set next step on opportunity when probability goes over 10%</description>
        <field>NextStep</field>
        <formula>&quot;Followup required&quot;</formula>
        <name>Set Next Step</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Probability Over 10</fullName>
        <actions>
            <name>Set_Next_Step</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Set next step when probability goes over 10</description>
        <formula>PRIORVALUE(Probability) &lt;= 0.1 &amp;&amp; Probability &gt; 0.1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>test email subject</fullName>
        <actions>
            <name>test_email_subject</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>greaterOrEqual</operation>
            <value>1000</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>testy</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
