module V1
  class BidSerializer < ActiveModel::Serializer
     attributes :id, :rate, :rate_type, :bid_amount, :buyer_id, :project_id
  end
end
