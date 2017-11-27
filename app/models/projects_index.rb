class ProjectsIndex

  DEFAULT_SORTING = {created_at: :desc}
  SORTABLE_FIELDS = [:created_at]
  PER_PAGE = 100

  delegate :params, to: :controller

  attr_reader :controller

  def initialize(controller)
    @controller = controller
  end

  def projects
    @projects = Project.order(sort_params).paginate(page: params[:page], per_page: params[:per_page].present? ? params[:per_page] : PER_PAGE)
  end

  def sort_params
    SortParam.sorted_fields(params[:sort], SORTABLE_FIELDS, DEFAULT_SORTING)
  end
 
end

