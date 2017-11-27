module V1

  class BuyersController < ApplicationController
    before_action :set_buyer, only: [:show, :update, :destroy]
    def index
      @buyers = Buyer.all
      json_response(@buyers)
    end

    def create
      @buyer = Buyer.create!(buyer_params)
      json_response(@buyer, :created)
    end

    def show
      json_response(@buyer)
    end

    def update
      if @buyer.update(buyer_params)
        head :no_content
      else
        raise ActiveRecord::RecordInvalid 
      end
    end

    def destroy
      @buyer.destroy
      head :no_content
    end

    private
    
    def buyer_params 
      params.permit(:uname, :email, :password)
    end

    def set_buyer
      @buyer = Buyer.find(params[:id])
    end
   
  end

end  
