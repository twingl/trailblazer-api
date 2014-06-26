Rails.application.routes.draw do
  # Authentication
  match '/auth/google_apps/callback', :to => 'sessions#create_google', :via => [:get, :post]
  match '/sign_out', :to => 'sessions#destroy', :via => [:get, :delete]

  # Org management
  resources :domains, :param => :domain_name, :only => [], :constraints => { :domain_name => /[0-9A-Za-z\-\.]+/ } do
    get :configure, :on => :member
  end

  # Misc pages
  match '/landing', :to => "pages#landing", :as => "landing", :via => [:get]
  match '/inactive', :to => "pages#inactive", :as => "inactive", :via => [:get]

  root :to => "pages#landing"
end
