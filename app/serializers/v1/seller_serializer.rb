module V1
   class SellerSerializer < ActiveModel::Serializer
     attributes :id, :uname
     # Shows all the corresponding projects that the seller has posted.
     has_many :projects
   end
end
