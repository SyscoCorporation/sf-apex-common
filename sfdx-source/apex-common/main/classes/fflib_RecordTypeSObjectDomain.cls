public virtual class fflib_RecordTypeSObjectDomain  extends fflib_SObjectDomain {
	public fflib_RecordTypeSObjectDomain(List<sObject> sObjectList) {
        super(sObjectList);
	}

	public fflib_RecordTypeSObjectDomain(List<sObject> sObjectList, String recordTypeName) {
        super(setFilter(sObjectList, recordTypeName));
	}
    
	private static List<SObject> setFilter(List<sObject> sObjectList, String recordTypeName) {
		List<SObject> mapOverride = new List<SObject>();
		String recordTypeIdFilter = sObjectList[0].getSObjectType().getDescribe()?.getRecordTypeInfosByName()?.get(recordTypeName)?.getRecordTypeId();

		for(sObject o : sObjectList) {
			String sObjRecType = o.isSet('RecordTypeId') ? o.get('RecordTypeId').ToString() : null;

			if(recordTypeIdFilter == sObjRecType) {
				mapOverride.add(o);
			}
		}

		return mapOverride;
	}

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new fflib_RecordTypeSObjectDomain(sObjectList);
        }
    }
}