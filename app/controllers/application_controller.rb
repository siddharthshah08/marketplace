
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

    #before_action :authenticate

    TOKEN_PATTERN = /Basic /

    def authenticate
        puts "here...."
        return false if request.headers["Authorization"].nil?
        token = request.headers["Authorization"].gsub(TOKEN_PATTERN, "")
        if Admin.authenticate(token)
            puts "treu........"
            return true
        else
          puts "here...."
          json_response({ error: "Admin authentication failed", code: '401' }, :unauthorized)
        end
    end

end
