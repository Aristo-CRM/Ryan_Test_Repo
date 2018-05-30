/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		This class is used for testing purposes only. 
		It shows record access by profile / role hierarchy
	
	Test Class: (current)
	Pages: N.A.
	History:
		Initial creation 2018/04/01

*/
@isTest
public class EmailUtilsTest {
    
    public static testMethod void RunTest() {
        
        test.startTest();
        
        // Single transation (for <10 emails)
        List<EmailUtils.EmailRequest> requestList = new List<EmailUtils.EmailRequest>{
            new EmailUtils.EmailRequest('recipient@example.com', 'subject #1', 'body'),
            new EmailUtils.EmailRequest('recipient@example.com;another@example.com', 'subject #2', 'body')
        };
        
		EmailUtils.sendEmail(requestList);
        
		// Queable transation (for >10 emails)
		while (requestList.size() <= 10)
            requestList.add(new EmailUtils.EmailRequest('recipient@example.com', 'subject #1', 'body'));        
        
		EmailUtils.sendEmail(requestList);
        
        test.stopTest();
	}
}