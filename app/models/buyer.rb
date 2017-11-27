class Buyer < User
  validates_presence_of :uname
  validates_presence_of :password
  validates_uniqueness_of :uname, :case_sensitive => false
  has_many :bids, dependent: :destroy

  before_create :encrypt_password

   def encrypt_password
       encrypted = User.encrypt(self.password)
       self.password = encrypted
   end
  
end
