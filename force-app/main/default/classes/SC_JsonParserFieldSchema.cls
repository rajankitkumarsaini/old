/*
Author : Ankit
Date : May 25, 2022
Desc: 
*/
public class SC_JsonParserFieldSchema{
        public String EntityDefinitionId{get;set;}
        public String SummaryOperation{get;set;}
        public String InlineHelpText{get;set;}
        public String RelationshipLabel{get;set;}
        public String MaskType{get;set;}
        public String Scale{get;set;}
        public String MaskChar{get;set;}
        public String Precision{get;set;}
        public String NamespacePrefix{get;set;}
        public String Length{get;set;}
        public String ManageableState{get;set;}
        public String Description{get;set;}
        public String CreatedDate{get;set;}
        public String DeveloperName{get;set;}
        public String CreatedById{get;set;}
        public String TableEnumOrId{get;set;}
        public String LastModifiedDate{get;set;}
        public String Id{get;set;}
        public String LastModifiedById{get;set;}
        public attributes attributes{get;set;}
        public Metadata Metadata{get;set;}
        public String FullName{get;set;}
    
    
    public class controllingFieldValue{
        public String controllingFieldValue{get;set;}
    }
    
    public class valueSettings{
        public list<String> controllingFieldValue{get;set;}
        public String valueName{get;set;}
    }
    public class valueSetDefinition{
        public list<value> value{get;set;}
        public Boolean sorted{get;set;}
    }
    public class valueSet{
        public valueSetDefinition valueSetDefinition{get;set;}
        public String valueSetName{get;set;}
        public String restricted{get;set;}
        public list<valueSettings> valueSettings{get;set;}
        public String controllingField{get;set;}
    }
    public class value{
        public String urls{get;set;}
        public String isActive{get;set;}
        public String description{get;set;}
        public String label{get;set;}
        public Boolean default_z{get;set;}
        public String valueName{get;set;}
        public String color{get;set;}
    }
    public class Metadata{
        public String maskType{get;set;}
        public String isConvertLeadDisabled{get;set;}
        public String isAIPredictionField{get;set;}
        public String isFilteringDisabled{get;set;}
        public String inlineHelpText{get;set;}
        public String isNameField{get;set;}
        public String formulaTreatBlanksAs{get;set;}
        public String isSortingDisabled{get;set;}
        public String formula{get;set;}
        public String label{get;set;}
        public Boolean externalId{get;set;}
        public String length{get;set;}
        public String externalDeveloperName{get;set;}
        public String lookupFilter{get;set;}
        public String escapeMarkup{get;set;}
        public String maskChar{get;set;}
        public String encryptionScheme{get;set;}
        public String metadataRelationshipControllingField{get;set;}
        public String displayLocationInDecimal{get;set;}
        public String mktDataLakeFieldAttributes{get;set;}
        public String displayFormat{get;set;}
        public String mktDataModelFieldAttributes{get;set;}
        public String description{get;set;}
        public String populateExistingRows{get;set;}
        public String deprecated{get;set;}
        public String precision{get;set;}
        public String deleteConstraint{get;set;}
        public String readOnlyProxy{get;set;}
        public String defaultValue{get;set;}
        public String referenceTargetField{get;set;}
        public String customDataType{get;set;}
        public String referenceTo{get;set;}
        public String complianceGroup{get;set;}
        public String relationshipLabel{get;set;}
        public String caseSensitive{get;set;}
        public String relationshipName{get;set;}
        public String businessStatus{get;set;}
        public String relationshipOrder{get;set;}
        public String businessOwnerUser{get;set;}
        public String reparentableMasterDetail{get;set;}
        public String businessOwnerGroup{get;set;}
        public Boolean required{get;set;}
        public Boolean trackFeedHistory{get;set;}
        public Boolean trackHistory{get;set;}
        public String summaryOperation{get;set;}
        public Boolean trackTrending{get;set;}
        public String summaryForeignKey{get;set;}
        public String translateData{get;set;}
        public String summaryFilterItems{get;set;}
        public String type{get;set;}
        public String summarizedField{get;set;}
        public String unique{get;set;}
        public String stripMarkup{get;set;}
        public String urls{get;set;}
        public String startingNumber{get;set;}
        public valueSet valueSet{get;set;}
        public String securityClassification{get;set;}
        public String visibleLines{get;set;}
        public String scale{get;set;}
        public String writeRequiresMasterRead{get;set;}
        public String restrictedAdminField{get;set;}
    }
    public class attributes{
        public String url{get;set;}
        public String type{get;set;}
    }
}