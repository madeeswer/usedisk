class Fmailer < ActionMailer::Base

 def mail(recipient, from, id, name, date, description)

    @from = "usedisk <no-reply@usedisk.com>"
    @recipients = from
    @subject = "File have been uploaded by you (FileName: #{name})"
    @download_url = id.to_s + "_" + name.to_s.gsub(".","_") + "_" + date.to_s
    @body = "Hi,\n\n#{name} file has been uploaded by you in usedisk.com.\n\nDescription: #{description}\n\nBelow mentioned is the Download URL,\nhttp://www.usedisk.com/downloads/" + @download_url.to_s + "\nUse the url and download the file.\n\nThanks for using UseDisk Service.\n\n\n\nThank you,\n\nusedisk.com\nAll users are our Premium Users. \n\n---------------------------------------------\nPlease do not reply to this email. Its a server generated mail."


  end


end
