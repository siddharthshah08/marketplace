module V1
  class ProjectsController < ApplicationController
  
     before_action :set_project, only: [:show, :update, :destroy]
     before_action :set_min_bid, only: [:show]
     after_action only: [:index] { set_pagination_headers(:projects) }
     after_action only: [:create] { set_created_link(:project) }
     before_action :set_status, only: [:create]
 
 # GET /projects
  def index  
    projects_index = ProjectsIndex.new(self)
    @projects = projects_index.projects
    #@projects = Project.order('created_at DESC').paginate(page: params[:page], per_page: params[:per_page].present? ? params[:per_page] : 100)
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
  end

  # PUT /projects/:id
  def update
    if @project.update(project_params)
        head :no_content
    else
       raise ActiveRecord::RecordInvalid
    end
 end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    head :no_content
  end

  private

  def set_status
     if self.status.blank?
       self.status = Project::STATUS_INACTIVE
     end
  end

  def project_params
    # whitelist params
    params.permit(:name, :description, :status, :starts_at, :ends_at, :accepting_bids_till, :seller_id)
  end

  def set_project
    @project = Project.find(params[:id])
  end
  
  def set_min_bid
    @lowest_bid = eval(@project.pq).first rescue "0.0"  
  end

  end

end  
