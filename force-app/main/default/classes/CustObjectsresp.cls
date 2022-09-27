public class CustObjectsresp {
    public string size;
    public string totalsize;
    public string done;
    public string querylocator;
    public string entityTypeName;
    public list<records>records;
        public class records{
             public Id id;
             public string DeveloperName;
             public Id CreatedById;
             public datetime CreatedDate;
             public Id LastModifiedById;
             public datetime LastModifiedByDate;
             public string Description;
             public string SaringModel;
            public string ManageableState;
            public string NamespacePrefix;
            public string MetaDataComponentName;
            public string MetaDataComponentType;
            public string ReMetaDataComponentName;
            public string ReMetaDataComponentId;
            
            
        }  
        
    }