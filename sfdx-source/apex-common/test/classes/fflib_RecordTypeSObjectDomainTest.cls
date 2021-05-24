
@IsTest
private with sharing class fflib_RecordTypeSObjectDomainTest 
{	
	@IsTest
	private static void testRecordTypeSetFilter()
	{
		fflib_RecordTypeSObjectDomain opps = new fflib_RecordTypeSObjectDomain(new List<Opportunity> { new Opportunity ( Name = 'Test', Type = 'Existing Account' ), new Opportunity ( Name = 'Test2', Type = 'Existing Account2' ) } );
        
        System.assertEquals(2, opps.Records.size());
	}

}