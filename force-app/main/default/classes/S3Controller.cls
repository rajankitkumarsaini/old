public class S3Controller {
	@AuraEnabled
public static void UploadDocToS3Server(string recordId)
{
AWSService service=new AWSService();
service.UploadDocuments(recordId);
}
}