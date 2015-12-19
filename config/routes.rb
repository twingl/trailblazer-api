Rails.application.routes.draw do
  namespace :trailblazer_admin do
    match '/users', :to => 'users#ui', :via => [:get]
    match '/users/search', :to => 'users#search', :via => [:get], :as => :users_search
  end

  use_doorkeeper do
    controllers :authorizations => 'oauth/authorizations', :applications => 'oauth/applications'
  end

  # Authentication
  match '/auth/google_apps_chooser/callback', :to => 'sessions#create_google', :via => [:get, :post]
  match '/auth/google_apps/callback', :to => 'sessions#create_google', :via => [:get, :post]
  match '/sign_in_method', :to => 'sessions#sign_in_method', :via => [:get], :as => :sign_in_method
  match '/sign_in', :to => 'sessions#new', :via => [:get], :as => :sign_in
  match '/sign_out', :to => 'sessions#destroy', :via => [:get, :delete], :as => :sign_out
  match '/change_user', :to => 'sessions#change_user', :via => [:get, :delete], :as => :change_user

  match '/sign_in', :to => 'sessions#create', :via => [:post]
  match '/sign_up', :to => 'registrations#create', :via => [:post], :as => :sign_up
  match '/forgot_password', :to => 'registrations#forgot_password', :via => [:post], :as => :forgot_password
  match '/forgot_password/:token', :to => 'registrations#reset_password', :via => [:get], :as => :edit_password

  match '/profile', :to => 'registrations#show', :via => [:get], :as => :profile
  match '/profile', :to => 'registrations#update', :via => [:post]

  match '/resend_confirmation', :to => 'registrations#resend_confirmation', :via => [:post], :as => :resend_confirmation
  match '/confirm/:token', :to => 'registrations#confirm', :via => [:get], :as => :confirm_email
  match '/revert/:token', :to => 'registrations#revert', :via => [:get], :as => :revert_email

  match '/me', :to => "users#me", :via => [:get], :as => :current_user_profile

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
      match '/backup', :to => "users#backup", :via => [:post]

      resources :assignments, :only => [:index, :create, :update, :destroy] do
        resources :nodes, :on => :member, :only => [:index, :create] do
          match :coords, :on => :collection, :to => "nodes#update_coords", :via => [:put, :patch]
        end
      end
      resources :nodes, :only => [:show, :update, :destroy] do
        match :bulk_delete, :on => :collection, :to => "nodes#bulk_destroy", :via => [:delete]
      end

      resources :projects, :only => [:index]
    end
  end

  namespace :public do
    match '/map/:token', :to => "maps#show", :via => [:get], :as => :map
  end

  # Misc pages
  match '/app', :to => "pages#app", :as => "app", :via => [:get]
  match '/coming_soon', :to => "pages#coming_soon", :as => "coming_soon", :via => [:get]
  match '/landing', :to => "pages#landing", :as => "landing", :via => [:get]
  match '/inactive', :to => "pages#inactive", :as => "inactive", :via => [:get]
  match '/bug', :to => "pages#bug", :as => "bug", :via => [:get]
  match '/feedback', :to => "pages#feedback", :as => "feedback", :via => [:get]

  root :to => "pages#landing"
end
