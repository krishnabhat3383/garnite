# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # %i[] is for an array of symbols separated by space, i.e. %i[lawl lol] = [:lawl, :lol]
  # for same use but for just strings, then use: %w[]
  defaults format: :json do
    resources :tasks, except: %i[new, edit], param: :slug
    resources :users, only: %i[index create]
    resource :sessions, only: %i[create destroy]
    resources :comments, only: :create
    resource :preferences, only: %i[show update]
  end
  root "home#index"

  get "*path", to: "home#index", via: :all
end
