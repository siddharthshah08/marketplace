class V1::ErrorsController < ApplicationController
  include Response
  def routing
    json_response({ error: "Resource end-point that you are looking for not found.", code: "404" }, :not_found) 
  end
end
