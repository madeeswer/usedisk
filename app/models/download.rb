class Download < ActiveRecord::Base
   set_table_name "usedisk.downloads"
    belongs_to :user
    belongs_to :uploads
#  validates_presence_of :verification, :message => "enter the validation characters"

#  validates_format_of :verification, :with => /\A[a-z0-9]*\Z/i, :message => "enter valid character"


  def self.download_path(id, filename, date)
    root = "/home/madhi"
    directory = root + "/data" + "/#{date}/"
    file_path = directory + id.to_s
    return file_path
  end

end
