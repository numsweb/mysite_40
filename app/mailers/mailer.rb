class Mailer < ActionMailer::Base
  
  def contact_notification(comment)

    setup_email(comment)
    @subject    = 'New contact created'
    @email  =  comment.email
    @comment = comment.comment
    mail(:to => @recipients, :from => @from, :subject => @subject, :email => @email, :comment => @comment)
  end
  
  
protected
  def setup_email(comment)
    @recipients  = "jkropka@oneoriginalgeek.com"
    @from        = comment.email
    @subject    = "Contact information from OneOriginalGeek.com"
    @sent_on     = Time.now
    @email = comment.email
    @message = comment.comment
    logger.info "body" + @body.inspect
  end
  
  
end