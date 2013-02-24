require 'resque/server'

HealthCan::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  match '/twilio/text', :to => 'twilio#text', :as => :twilio_text, :via => :post
  match '/twilio/voice', :to => 'twilio#voice', :as => :twilio_text, :via => :post
  match '/dashboard', :to => "home#dashboard", :as => :dashboard

  devise_for :users
  resources :users

  resources :requests do
    member do
      post :approve
      post :ignore
    end
  end

  mount Resque::Server, :at => "/resque"

  root :to => "home#index"

end