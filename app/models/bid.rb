class Bid < ApplicationRecord
  belongs_to :buyer
  belongs_to :project
  validates_presence_of :rate

  validate :bidding_is_still_active, :on => :create
  #after_create :update_project_minimum_bid
  after_create :update_project_minimum_bid_pq #, :add_self_as_observer

  HOURLY = "Hourly"
  FIXED_RATE = "Fixed_rate"
 
  OPEN = "Open"
  CLOSED = "Closed"

  
  def update_project_minimum_bid
    project = Project.find(self.project_id)
    bid_amount = self.bid_amount
    
    if project.pq.nil?
      project.pq = bid_amount 
    elsif project.pq.to_f > bid_amount.to_f
      project.pq = bid_amount 
      project.lowest_bid_id = self.id
    end
    project.save
  end

  def update_project_minimum_bid_pq
     if(!self.project_id.nil?)
        project = Project.find(self.project_id)
        bid_amount = self.bid_amount

        if project.pq.nil?
          pq = PQueue.new([bid_amount])
          project.pq = pq.to_a.to_s
	  project.lowest_bid_id = self.id
	else 
          arr = eval(project.pq)
          pq = PQueue.new(arr)
          pq.push(bid_amount)
	  project.pq = pq.to_a.to_s
          if arr.first.to_f > bid_amount.to_f
             project.lowest_bid_id = self.id 
          end
        end
          project.save
     end
  end

  def add_self_as_observer
    project = Project.find(self.project_id)
    project.add_observer(self)
  end
   
  def update 
  

  end

  private

   def bidding_is_still_active
     project = Project.find(self.project_id)
     if !project.nil?
	 now = DateTime.now.utc
         if project.accepting_bids_till.utc < now
           errors.add(:rate, "cannot be accepted as project is not accepting bids.")        
     	end
     end
   end
   
end
