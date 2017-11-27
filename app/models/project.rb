require 'observer'
class Project < ApplicationRecord
  include Observable
  belongs_to :seller
  has_many :bids,	 dependent: :destroy
  validates_presence_of :name, :description, :starts_at, :ends_at, :accepting_bids_till
  validate :ends_at_is_after_starts_at
  validate :accpeting_bids_till_one_day_before_start

  STATUS_BIDDING_CLOSED = "Bidding closed"
  STATUS_CREATED = "Created"
  STATUS_ACTIVE = "Active"
  STATUS_INACTIVE = "Inactive"

   
  def self.cease_bidding
     now = DateTime.now.utc
     projects = Project.where('accepting_bids_till < ?', now).update(:status => STATUS_BIDDING_CLOSED)
     if(!projects.nil? and projects.size >= 1)
        # change status of the bid from 'Open' to 'Closed'
        bid_ids = projects.map(&:lowest_bid_id)
	bids = Bid.find(bid_ids)
	bids.each{ |bid| 
	   bid.status = Bid::CLOSED 
	   bid.save
	}
        # create an entry in engagements table.
     end
  end


  private

   def ends_at_is_after_starts_at
     return if ends_at.nil? or starts_at.nil?
     if ends_at < starts_at
       errors.add(:ends_at, "cannot be before the start date") 
     end 
   end
   
   def accpeting_bids_till_one_day_before_start
     return if accepting_bids_till.nil? or starts_at.nil?

     if accepting_bids_till > (starts_at - 1.hours)
       errors.add(:accepting_bids_till, "only 1 hour before the start date.")
     end
   end
end
