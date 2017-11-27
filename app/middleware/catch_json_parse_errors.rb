class CatchJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)

    rescue ActiveRecord::RecordNotFound => error
      if env['HTTP_ACCEPT'] =~ /application\/json/ || env['CONTENT_TYPE'] =~ /application\/json/
       return [
          404, { "Content-Type" => "application/json" },
          [ { status: 404, error: error }.to_json ]
       ]
      else
        raise error
      end
     
    rescue ActiveRecord::RecordInvalid => invalid_error
      if env['HTTP_ACCEPT'] =~ /application\/json/ || env['CONTENT_TYPE'] =~ /application\/json/
       return [
          422, { "Content-Type" => "application/json" },
          [ { status: 422, error: invalid_error }.to_json ]
       ]
      else
        raise error
      end 
     
    rescue ActionDispatch::ParamsParser::ParseError => error
     if env['HTTP_ACCEPT'] =~ /application\/json/ || env['CONTENT_TYPE'] =~ /application\/json/   
       return [
          400, { "Content-Type" => "application/json" },
          [ { status: 400, error: "Could not parse the requested payload : #{error}" }.to_json ]
       ] 
     else
        raise error
     end

    rescue ActiveRecord::RecordNotSaved => error
      if env['HTTP_ACCEPT'] =~ /application\/json/ || env['CONTENT_TYPE'] =~ /application\/json/
       return [
          422, { "Content-Type" => "application/json" },
          [ { status: 422, error: error }.to_json ]
       ]
      else
        raise error
      end

    rescue StandardError => error
      if env['HTTP_ACCEPT'] =~ /application\/json/ || env['CONTENT_TYPE'] =~ /application\/json/
       return [
          500, { "Content-Type" => "application/json" },
          [ { status: 500, error: error }.to_json ]
       ]
      else
        raise error
      end

    end
  end
end
