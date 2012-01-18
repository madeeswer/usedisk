class User < ActiveRecord::Base
#schema_search_path= 'usedisk,public'
#dsdsschema_search_path= 'usedisk,public'
  set_table_name "usedisk.users"
  acts_as_authentic
  
  has_many :uploads
  has_many :downloads
  validates_format_of :login, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => ": Enter valid email id"
 
  
  def self.validate_on_create
    validates_presence_of :login
    validates_presence_of :password
    
  
    validates_length_of :login, :within => 6..20, :too_long => "pick a shorter name", :too_short => ": Pick a longer name"
    validates_length_of :password, :within => 8..20, :too_long => "pick a shorter password", :too_short => ": Pick a longer password. Minimum of 8 characters should be used"
  end
end
