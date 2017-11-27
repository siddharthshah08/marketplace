class Admin < User

   validates_presence_of :uname
   validates_presence_of :password
   validates_uniqueness_of :uname, :case_sensitive => false
  
   before_create :encrypt_password
   
   def encrypt_password
       encrypted = User.encrypt(self.password)
       self.password = encrypted
   end
  
   # authenticates user against the password provided in the Basic base64 token 
   def self.authenticate(token)
        decoded_token = Base64.decode64(token)
        admin_password = Admin.first.password
        token_password = User.encrypt(decoded_token.split(":")[1])
        if admin_password == token_password
           return true
        else
           return false
        end
   end


end
