class Emailer < ActionMailer::Base

 def mail(recipient, from, id, name, date, description)

    @from = "usedisk <no-reply@usedisk.com>"
    @recipients = recipient
    @subject = "File have been sent to you (FileName: #{name})"
    @download_url = id.to_s + "_" + name.to_s.gsub(".","_") + "_" + date.to_s
    @body = "Hi,\n\n#{name} file has been uploaded in usedisk.com.\n\nDescription: #{description}\n\nBelow mentioned is the Download URL,\nhttp://www.usedisk.com/downloads/" + @download_url.to_s + "\nUse the url and download the file.\n\nThanks for using UseDisk Service.\n\nYour mail id has been given by #{from}\n\n\nThank you,\n\nusedisk.com\nAll users are our Premium Users. \n\n---------------------------------------------\nPlease do not reply to this email. Its a server generated mail."


  end


end
