module V1

  class SellersController < ApplicationController
    before_action :set_seller, only: [:show, :update, :destroy]    
    def index
       @sellers = Seller.all
       json_response(@sellers)
    end
  
    def create
      @seller = Seller.create!(seller_params)
      json_response(@seller, :created)
    end

  
    def show
       json_response(@seller)	
    end

  
    def update
      if @seller.update(seller_params)
      	head :no_content
      else
        raise ActiveRecord::RecordInvalid
      end
    end

    def destroy
      @seller.destroy
      head :no_content    
    end

    private

    def seller_params
      params.permit(:uname, :email, :password)  
    end
    
    def set_seller
      @seller = Seller.find(params[:id])
    end 
  end	
	
end
