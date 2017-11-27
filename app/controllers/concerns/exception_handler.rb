module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
	json_response({ error: e.message, code: '404' }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ error: e.message, code: '422' }, :unprocessable_entity)
    end
  end
  
end
