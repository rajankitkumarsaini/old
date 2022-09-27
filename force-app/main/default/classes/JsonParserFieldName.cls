public class JsonParserFieldName{
		public String entityTypeName{get;set;}
		public Boolean done{get;set;}
		public String queryLocator{get;set;}
		public Integer totalSize{get;set;}
		public list<records> records{get;set;}
		public Integer size{get;set;}
	public class records{
		public String DeveloperName{get;set;}
		public attributes attributes{get;set;}
	}
	public class attributes{
		public String type{get;set;}
		public String url{get;set;}
	}
}