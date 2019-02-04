<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Birthday_Wish_Email</fullName>
        <description>Birthday Wish Email</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Birthday_Wishes</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert</fullName>
        <description>Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Birthday_Wishes</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Contact</fullName>
        <description>Send Email to Contact</description>
        <protected>false</protected>
        <recipients>
            <recipient>salesforceadvancepractice@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Birthday_Wishes</template>
    </alerts>
    <rules>
        <fullName>Birthday Alert</fullName>
        <active>true</active>
        <formula>(MONTH(Birthdate)  =  Month(TODAY()))  &amp;&amp; (DAY(Birthdate)  =  DAY(TODAY()))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Birthday_Wish_Email</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Send reminder after 1 day</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Birthdate</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
