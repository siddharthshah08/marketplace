require 'api_version'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :sellers
    resources :buyers
    resources :bids, except: :update
    resources :projects


    resources :sellers do
      resources :projects
    end

    resources :projects do
      resources :bids
    end

    resources :buyers do
      resources :bids
    end
    match '*a', :to => 'errors#routing', :via => [:all]
  end

  scope module: :v1, defaults: {format: :json}, constraints: ApiVersion.new('v1', true) do
    resources :sellers
    resources :buyers
    resources :bids, except: :update
    resources :projects
   
=begin
    resources :sellers do
      resources :projects
    end

    resources :projects do
      resources :bids
    end
   
    resources :buyers do
      resources :bids
    end
=end

    #custom route
    #match 'custom', :to => 'projects#index', :via => [:get]
    #match 'custom', :controller => :projects, :action => 'index', :via =>[:all] 
   
     #to handle unknown routes.
     match '*a', :to => 'errors#routing', :via => [:all]
  end
end
