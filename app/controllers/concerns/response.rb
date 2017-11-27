module Response
  def json_response(object, status = :ok)
     render json: object, status: status
  end
 
  def set_pagination_headers(name)
    scope = instance_variable_get("@#{name}")
    pages = set_page_numbers(scope)
    links = create_links(pages, scope)

    headers['Link'] = links.join(', ') unless links.empty?
    headers['X-Total-Count'] = scope.total_entries 
  end

  def set_created_link(name)
    scope = instance_variable_get("@#{name}")
    id = scope.id
    url_without_params = request.url.split('?').first
    headers['Link'] = "#{url_without_params}/#{id}"
  end

  private

  def create_links(pages, scope)
    url_without_params = request.url.split('?').first

    if params[:per_page]
      per_page = params[:per_page].to_i
    else
      per_page = scope.per_page
    end

    links = []
    pages.each do |key, value|
      new_params = request.query_parameters.merge({ page: value, per_page: per_page })
      links << "<#{url_without_params}?#{new_params.to_param}>; rel=\"#{key}\""
    end
    links
  end

  def set_page_numbers(scope)
    pages = {}
    pages[:first] = 1 if scope.total_pages > 1 && scope.current_page > 1
    pages[:prev] = scope.current_page - 1 if scope.current_page > 1
    pages[:next] = scope.current_page + 1 if scope.current_page < scope.total_pages
    pages[:last] = scope.total_pages if scope.total_pages > 1 && scope.current_page < scope.total_pages
    pages
  end

end
