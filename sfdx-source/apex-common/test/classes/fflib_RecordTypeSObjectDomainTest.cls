
@IsTest
private with sharing class fflib_RecordTypeSObjectDomainTest 
{	
	@IsTest
	private static void testRecordTypeConst()
	{
		fflib_RecordTypeSObjectDomain opps = new fflib_RecordTypeSObjectDomain(new List<Opportunity> { new Opportunity ( Name = 'Test', Type = 'Existing Account' ), new Opportunity ( Name = 'Test2', Type = 'Existing Account2' ) } );
        
        System.assertEquals(2, opps.Records.size());
	}

	@IsTest
	private static void testRecordTypeConstSetFilter()
	{
		fflib_RecordTypeSObjectDomain opps = new fflib_RecordTypeSObjectDomain(new List<Opportunity> { new Opportunity ( Name = 'Test', Type = 'Existing Account' ), new Opportunity ( Name = 'Test2', Type = 'Existing Account2' ) }, null );
        
        System.assertEquals(2, opps.Records.size());
	}

	@IsTest
	private static void testInsert()
	{
		List<Opportunity> opps = new List<Opportunity> { new Opportunity ( Name = 'Test', Type = 'Existing Account' ), new Opportunity ( Name = 'Test2', Type = 'Existing Account2' ) };
        
		fflib_SObjectDomain.Test.Database.onInsert(opps);
		fflib_SObjectDomain.triggerHandler(fflib_RecordTypeSObjectDomain.class);
	}

	@IsTest
	private static void testUpdate()
	{
		Opportunity oldOpp = (Opportunity) Opportunity.sObjectType.newSObject('006E0000006mkRQ');
		oldOpp.Name = 'Test';
		oldOpp.Type = 'Existing'; 
		Opportunity newOpp = (Opportunity) Opportunity.sObjectType.newSObject('006E0000006mkRQ'); 
		newOpp.Name = 'Test';
		newOpp.Type = 'New'; 

		fflib_SObjectDomain.Test.Database.onUpdate(new List<Opportunity>{ newOpp }, new Map<Id, Opportunity>{ newOpp.Id => oldOpp });
		fflib_SObjectDomain.triggerHandler(fflib_RecordTypeSObjectDomain.class);
	}



	@IsTest
	private static void testDelete()
	{
		Opportunity opp  = (Opportunity) Opportunity.sObjectType.newSObject('006E0000006mkRQ');
		opp.Name = 'Test';
		opp.Type = 'Existing';

		fflib_SObjectDomain.Test.Database.onDelete(new Map<Id, Opportunity>{ opp.Id => opp });
		fflib_SObjectDomain.triggerHandler(fflib_RecordTypeSObjectDomain.class);
	}

	@IsTest
	private static void testUnDelete()
	{
		List<Opportunity> opps = new List<Opportunity> { new Opportunity ( Name = 'Test', Type = 'Existing Account' ), new Opportunity ( Name = 'Test2', Type = 'Existing Account2' ) };
        
		fflib_SObjectDomain.Test.Database.onUndelete(opps);
		fflib_SObjectDomain.triggerHandler(fflib_RecordTypeSObjectDomain.class);
	}



	private class Opportunities extends fflib_RecordTypeSObjectDomain
	{
		public Opportunities(List<SObject> records)
		{
			super(records, null);
		}
	}
}