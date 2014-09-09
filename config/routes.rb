Rails.application.routes.draw do
  use_doorkeeper do
    controllers :authorizations => 'authorizations'
  end

  # Authentication
  match '/auth/google_apps_chooser/callback', :to => 'sessions#create_google', :via => [:get, :post]
  match '/auth/google_apps/callback', :to => 'sessions#create_google', :via => [:get, :post]
  match '/sign_out', :to => 'sessions#destroy', :via => [:get, :delete]
  match '/change_user', :to => 'sessions#change_user', :via => [:get, :delete], :as => :change_user

  match '/me', :to => "users#me", :via => [:get]

  # Org management
  resources :domains, :param => :domain_name, :only => [], :constraints => { :domain_name => /[0-9A-Za-z\-\.]+/ } do
    get :configure, :on => :member
  end

  resources :users, :only => [] do
    post :update_roles, :on => :collection

    match :assignments, :on => :member, :to => "assignments#user_index", :via => [:get]

    get :search,   :on => :collection
    get :students, :on => :collection
    get :teachers, :on => :collection
  end

  resources :classrooms do
    match :enroll, :on => :member, :to => "classrooms#enroll", :via => [:put, :patch]
    match :withdraw, :on => :member, :to => "classrooms#withdraw", :via => [:put, :patch]

    match :activate, :on => :member, :to => "classrooms#activate", :via => [:post]

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

  # API resource routes
  namespace :api do
    namespace :v1 do
      match '/me', :to => "users#me", :via => [:get]

      resources :assignments, :only => [:index, :create, :update] do
        resources :nodes, :on => :member, :only => [:index, :create] do
          match :coords, :on => :collection, :to => "nodes#update_coords", :via => [:put, :patch]
        end
      end
      resources :nodes, :only => [:show, :update, :destroy]

      resources :projects, :only => [:index]
    end
  end

  # Misc pages
  match '/app', :to => "pages#app", :as => "app", :via => [:get]
  match '/coming_soon', :to => "pages#coming_soon", :as => "coming_soon", :via => [:get]
  match '/landing', :to => "pages#landing", :as => "landing", :via => [:get]
  match '/inactive', :to => "pages#inactive", :as => "inactive", :via => [:get]

  root :to => "pages#landing"
end
