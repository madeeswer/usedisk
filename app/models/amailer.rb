class Amailer < ActionMailer::Base

 def mail(id, activation, captcha)
 
    @from = "usedisk <no-reply@usedisk.com>"
    @recipients = recipient
    @subject = "UseDisk's user Activation process"
    @download_url = activation.to_s + "_" + id.to_s
    @body = "Hi,\n\n#You have succesfully registered your account.\n\nThis account needs to be activated by you to use it. Kindly click the link inorder to activate the premium user account\n\nhttp://www.usedisk.com/activate/" + @download_url.to_s + "\n\n\nThank you,\n\nusedisk.com\nAll users are our Premium Users. \n\n---------------------------------------------\nPlease do not reply to this email. Its a server generated mail."
 

  end
  

end
