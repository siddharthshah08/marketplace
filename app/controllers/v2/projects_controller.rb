module V2
  class ProjectsController < ApplicationController
  
     before_action :check_set_seller 
     before_action :set_project, only: [:show, :update, :destroy]
     before_action :set_min_bid, only: [:show]
     after_action only: [:index] { set_pagination_headers(:projects) }
     PER_PAGE = 100  
  # GET /projects
  def index  
    if @seller.nil?
    	@projects = Project.order('created_at DESC').paginate(page: params[:page], per_page: params[:per_page].present? ? params[:per_page] : PER_PAGE)
    else
        @projects = @seller.projects.paginate(page: params[:page], per_page: params[:per_page].present? ? params[:per_page] : PER_PAGE)
    end
    json_response(@projects)
  end

  # POST /projects
  def create
    @project = Project.create!(project_params)
    json_response(@project, :created)
  end

  # GET /projects/:id
  def show
     render json: @project, scope: {
  	  'lowest_bid': @lowest_bid
     }
     #json_response(@project)
  end

  # PUT /projects/:id
  def update
    @project.update(project_params)
    head :no_content
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    head :no_content
  end

  private

  def project_params
    # whitelist params
    params.permit(:name, :description, :status, :starts_at, :ends_at, :accepting_bids_till, :seller_id)
  end

  def set_project
    if @seller.nil?
    	@project = Project.find(params[:id])
    else
       if @seller.projects.ids.include? (params[:id].to_i)
    	  @project = Project.find(params[:id])
       else
          raise ActiveRecord::RecordNotFound, "Project #{params[:id].inspect} does not belog to this #{@seller.id.inspect} seller"
          # else raise ActiveRecord record not found project does not belong to this seller.
       end
    end
  end
  
  def set_min_bid
    @lowest_bid = eval(@project.pq).first rescue "-"  
  end

  def check_set_seller
    if !params[:seller_id].nil?
       @seller = Seller.find(params[:seller_id]) rescue nil
       if @seller.nil?
           raise ActiveRecord::RecordNotFound, "Couldn't find seller with ID=#{params[:seller_id].inspect} "
 	   # raise seller does not exist
       end
    end
  end


  end

end  
