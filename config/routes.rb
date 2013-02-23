require 'resque/server'

HealthCan::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  devise_for :users
  resources :users


  mount Resque::Server, :at => "/resque"

  root :to => "home#index"

end