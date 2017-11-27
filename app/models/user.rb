class User < ApplicationRecord

   PASSWORD_SALT = "Alohomora"
    
   def self.encrypt(pwd)      
      Digest::SHA1.hexdigest("#{PASSWORD_SALT}--#{pwd}--")
   end


end
