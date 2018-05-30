/* ---------------------------------------------------
	Author: 	Paul Perry
	Company:	Sqware Peg
	Description: 
		PoC Sending emails to custom emailaddresses (for emailgroups requiring notification emails)

		This class provides a Process Builder Apex Task. This can be used to send an email by 
		providing subject, html email body and sender (;-separated for multiple ones).

		Bulkproof solution. Please check your organizational limits
	
	Test Class: EmailUtilsTest
	Pages: N.A.
	History:
		Initial creation 2018/04/26
*/

global without sharing class EmailUtils {
	
	@InvocableMethod(label = 'Send emails' description = 'Send HTML email to recipients')
  	public static void sendEmail(List<EmailRequest> requestList) {
        if (requestList.size() < 10) {
            PerformEmailAction(requestList);
            return;
        }
        
        System.enqueueJob(new EmailQueueable(requestList));
	}
    
    private static void PerformEmailAction(List<EmailRequest> emailsRequestList) {
        if (emailsRequestList.size() == 0) return;
        if (emailsRequestList.size() > 10) 
            throw new EmailUtilException('Not allowed sending >10 emails at the same time');
	        
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        
        integer cnt = 0;
        boolean processNext = true;
        
        do {                
            EmailRequest er = emailsRequestList.get(0);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(er.recipient.split(';'));
            mail.setSubject(er.subject);
            mail.setHtmlBody(er.body);    
            emailMessages.add(mail);
            
            emailsRequestList.remove(0);
            processNext = 
                cnt++ < 10 && emailsRequestList.size() > 0;
            
        } while (processNext);
        
        if (emailMessages.size() > 0) 
            if (!Test.isRunningTest()) 
            	Messaging.SendEmailResult[] result = Messaging.sendEmail(emailMessages, false);
    }

    global class EmailRequest {
        @InvocableVariable(required=true label='Emailaddress' description='Email address(es) separated by ; (semicolon)')
        public String recipient;
        
        @InvocableVariable(required=true label='Subject' description='Email subject')
        public String subject;
        
        @InvocableVariable(required=true label='HTML Body' description='Message body in HTML format')
        public String body;
        
        // method constructor
        public EmailRequest(String recipient, String subject, String body) {
            this.recipient = recipient;
            this.subject = subject;
            this.body = body;
        }
    }    
    
    public without sharing class EmailQueueable implements Queueable {
        
        List<EmailRequest> emailRequestList = null;
        
        public EmailQueueable(List<EmailRequest> requests) {
            this.emailRequestList = requests;
        }
        
        public void process(QueueableContext context) {
            if (this.emailRequestList.size() == 0) return;
            
            integer cnt = 0;
            boolean processNext = true;
            
            List<EmailRequest> toBeSent = new List<EmailRequest>();
            
            do {                
            	toBeSent.add(this.emailRequestList.get(0));                
                this.emailRequestList.remove(0);
                
                processNext = 
                    cnt++ < 10 
                    && this.emailRequestList.size() > 0;                    
            } while (processNext);
            
            if (toBeSent.size() > 0) 
                if (!Test.isRunningTest()) 
                	EmailUtils.PerformEmailAction(toBeSent);
            
            if (this.emailRequestList.size() > 0) 
                System.enqueueJob(new EmailQueueable(this.emailRequestList));
        }
        
        public void execute(QueueableContext context) {
            if (this.emailRequestList != null) {
                process(context);
                return;
            }
        }
    } 
    
    // Class for custom Exception
    private class EmailUtilException extends Exception {}
}