module V1
   class ProjectSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :status, :starts_at, :ends_at, :accepting_bids_till, :lowest_bid #, :bids
      attribute :lowest_bid, if: :lowest_bid_exist?

      def lowest_bid
         return scope[:lowest_bid] if !scope.nil?
      end
   
      def lowest_bid_exist?
         !scope.nil? && !scope[:lowest_bid].nil?
      end

      #def bids
      #   return object.bids.size
      #end
      #has_many :bids
   end
end
