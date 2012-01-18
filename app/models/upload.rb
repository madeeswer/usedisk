class Upload < ActiveRecord::Base
  set_table_name "usedisk.uploads"
  belongs_to :user
  validates_presence_of :filename, :message => "enter the file name"
  validates_presence_of :to_email, :message => "enter the to eMail ID"
  validates_presence_of :from_email, :message => "enter the from eMail ID"

  validates_format_of :to_email, :with => /\A(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}) *\,? *)+\Z/i, :message => "enter valid email id"
  validates_format_of :from_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "enter valid email id"

  validates_length_of :description, :maximum => 100, :too_long => "pick a shorter description"

  
  def self.copy(id, upload, date)

    name =  upload['filename'].original_filename
    root = "/home/maspi0"
#    directory = root + "/data" + "/#{@date.strftime('%Y-%m-%d')}"
#     directory = root + "/data" + "/#{Date.today.strftime('%Y-%m-%d')}/"

#    directory = "public/data/"
     directory = root + "/data" + "/#{date}/"
 
    # create the file path
    if FileTest.directory?(directory)
      path = File.join(directory, id.to_s)
      # write the file
      File.open(path, "wb") { |f| f.write(upload['filename'].read) }
    else
      FileUtils.mkdir(directory)
      path = File.join(directory, id.to_s)
      # write the file
      File.open(path, "wb") { |f| f.write(upload['filename'].read) }
      
    end 
    return path
  end
  
  def self.delete_file(id, date)

    root = "/home/maspi0"
#    directory = root + "/data" + "/#{@date.strftime('%Y-%m-%d')}"
#     directory = root + "/data" + "/#{Date.today.strftime('%Y-%m-%d')}/"

#    directory = "public/data/"
     full_path = root + "/data" + "/#{date}/" + id.to_s
     File.delete(full_path) 

    return true
    
  end


  
end
