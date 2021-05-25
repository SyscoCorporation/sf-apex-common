public virtual class fflib_RecordTypeSObjectDomain  extends fflib_SObjectDomain {
	public fflib_RecordTypeSObjectDomain(List<sObject> sObjectList) {
        super(sObjectList);
	}

	public fflib_RecordTypeSObjectDomain(List<sObject> sObjectList, String recordTypeName) {
        super(setFilter(sObjectList, recordTypeName), sObjectList.getSObjectType());
	}
    
	private static List<SObject> setFilter(List<sObject> sObjectList, String recordTypeName) {
		List<SObject> mapOverride = new List<SObject>();
		String recordTypeIdFilter = sObjectList.getSObjectType().getDescribe()?.getRecordTypeInfosByName()?.get(recordTypeName)?.getRecordTypeId();

		for(sObject o : sObjectList) {
			String sObjRecType = o.isSet('RecordTypeId') ? o.get('RecordTypeId').ToString() : null;

			if(recordTypeIdFilter == sObjRecType) {
				mapOverride.add(o);
			}
		}

		return mapOverride;
	}

    /**
     * Overriden handler for the Apex Trigger event Before Update, calls the onBeforeInsert method
     **/
	public virtual override void handleBeforeInsert() 
    { 
		if(Records.isEmpty()){
			return;
		}

    	onApplyDefaults(); 
    	onBeforeInsert();
		
    }


    /**
     * Overriden handler for the Apex Trigger event Before Update, calls the onBeforeUpdate method
     **/
    public virtual override void handleBeforeUpdate(Map<Id,SObject> existingRecords) 
    {
		if(Records.isEmpty()){
			return;
		}

    	onBeforeUpdate(existingRecords);
    }
    
    /**
     * Overriden handler for the Apex Trigger event Before Delete, calls the onBeforeDelete method
     **/
    public virtual override void handleBeforeDelete() 
    {
		if(Records.isEmpty()){
			return;
		}

    	onBeforeDelete();
    }
    
    /**
     * Overriden handler for the Apex Trigger event After Insert, checks object security and calls the onValidate and onAfterInsert methods
     *
     * @throws DomainException if the current user context is not able to create records
     **/
    public virtual override void handleAfterInsert()
    {
		if(Records.isEmpty()){
			return;
		}

    	if(Configuration.EnforcingTriggerCRUDSecurity && !SObjectDescribe.isCreateable()) 
    	   throw new DomainException('Permission to create an ' + SObjectDescribe.getName() + ' denied.');
    	   
    	onValidate();
    	onAfterInsert(); 
    }
    
    /**
     * Overriden handler for the Apex Trigger event After Update, checks object security and calls the onValidate, onValidate(Map<Id,SObject>) and onAfterUpdate methods
     *
     * @throws DomainException if the current user context is not able to update records
     **/
    public virtual override void handleAfterUpdate(Map<Id,SObject> existingRecords) 
    {    	
		if(Records.isEmpty()){
			return;
		}

    	if(Configuration.EnforcingTriggerCRUDSecurity && !SObjectDescribe.isUpdateable()) 			    		
    	   throw new DomainException('Permission to update an ' + SObjectDescribe.getName() + ' denied.');
    	
    	if(Configuration.OldOnUpdateValidateBehaviour)
    		onValidate();
    	onValidate(existingRecords);
    	onAfterUpdate(existingRecords); 
    }
    
    /**
     * Overriden handler for the Apex Trigger event After Delete, checks object security and calls the onAfterDelete method
     *
     * @throws DomainException if the current user context is not able to delete records
     **/
    public virtual override void handleAfterDelete() 
    {
		if(Records.isEmpty()){
			return;
		}

    	if(Configuration.EnforcingTriggerCRUDSecurity && !SObjectDescribe.isDeletable())
    	   throw new DomainException('Permission to delete an ' + SObjectDescribe.getName() + ' denied.');
    	   
    	onAfterDelete();
    }	
    /**
     * Overriden handler for the Apex Trigger event After Undelete, checks object security and calls the onAfterUndelete method
     *
     * @throws DomainException if the current user context is not able to delete records
     **/
    public virtual override void handleAfterUndelete() 
    {
		if(Records.isEmpty()){
			return;
		}

    	if(Configuration.EnforcingTriggerCRUDSecurity && !SObjectDescribe.isCreateable())
    	   throw new DomainException('Permission to create an ' + SObjectDescribe.getName() + ' denied.');
    	   
    	onAfterUndelete();
    }	


    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new fflib_RecordTypeSObjectDomain(sObjectList);
        }
    }
}