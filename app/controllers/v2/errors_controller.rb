class V2::ErrorsController < ApplicationController
  include Response
  def routing
    json_response({ error: "Resource end-point that you are looking for in API version V2 is not yet built.", code: "404" }, :not_found) 
  end
end
