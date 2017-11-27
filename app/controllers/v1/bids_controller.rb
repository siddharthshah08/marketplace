module V1

  class BidsController < ApplicationController
    before_action :set_bid, only: [:show, :update, :destroy]
  # GET /bids
  def index
    @bids = Bid.all
    json_response(@bids)
  end

  # POST /bids
  def create
    @bid = Bid.create!(calculated_bid_params)
    json_response(@bid, :created)
  end


  # GET /bids/:id
  def show
    json_response(@bid)
  end

  # DELETE /bids/:id
  def destroy
    @bid.destroy
    head :no_content
  end

  private

  def bid_params
    # whitelist params
    params.permit(:buyer_id, :project_id, :rate, :rate_type)
  end
  
  def calculated_bid_params
    params = bid_params
    project = Project.find(params['project_id']) rescue nil
    if !project.nil?
      duration = (project.ends_at - project.starts_at).to_i / (24 * 60 * 60)
      rate = params['rate']
      params['rate_type'] = (!params['rate_type'].blank? ? params['rate_type'] : Bid::HOURLY)
      params['status'] = (!params['status'].blank? ? params['status'] : Bid::OPEN)
      case params['rate_type']
        when Bid::HOURLY
          bid_amount = (rate.to_f * duration.to_f * 8).round(2)
        when Bid::FIXED_RATE
          bid_amount = rate.to_f.round(2)
        else
          bid_amount = rate.to_f.round(2)
      end
      params.merge!(:bid_amount => bid_amount)
    else
      return bid_params
    end
  end
  
  
  def set_bid  
    @bid = Bid.find(params[:id])
  end

  end

end
