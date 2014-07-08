Rails.application.routes.draw do
  # Authentication
  match '/auth/google_apps/callback', :to => 'sessions#create_google', :via => [:get, :post]
  match '/sign_out', :to => 'sessions#destroy', :via => [:get, :delete]

  match '/me', :to => "users#me", :via => [:get]

  # Org management
  resources :domains, :param => :domain_name, :only => [], :constraints => { :domain_name => /[0-9A-Za-z\-\.]+/ } do
    get :configure, :on => :member
  end

  resources :users, :only => [] do
    post :update_roles, :on => :collection

    get :search,   :on => :collection
    get :students, :on => :collection
    get :teachers, :on => :collection
  end

  resources :classrooms do
    match :enroll, :on => :member, :to => "classrooms#enroll", :via => [:put, :patch]
    match :withdraw, :on => :member, :to => "classrooms#withdraw", :via => [:put, :patch]

    resources :users, :only => [:index] do
      get :students, :on => :collection
      get :teachers, :on => :collection
    end

    resources :projects
  end

  resources :projects, :only => [:show, :update, :destroy] do
    match :assign, :on => :member, :to => "projects#assign", :via => [:put, :patch]

    resources :assignments
  end

  # Misc pages
  match '/landing', :to => "pages#landing", :as => "landing", :via => [:get]
  match '/inactive', :to => "pages#inactive", :as => "inactive", :via => [:get]

  root :to => "pages#landing"
end
