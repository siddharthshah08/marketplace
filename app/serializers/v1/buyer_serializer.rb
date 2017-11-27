module V1   
   class BuyerSerializer < ActiveModel::Serializer
     attributes :id, :uname
     # Shows all bids that the seller has bid for 
     has_many :bids
   end
end
