class Application < Rails::Application
   config.middleware.use CatchJsonParseErrors
end
