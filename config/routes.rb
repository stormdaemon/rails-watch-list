Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "search_movies", to: "movies#search"

  resources :movies

  root to: "lists#index"

  resources :lists, except: [:index] do
    resources :bookmarks, only: [:create]
  end

  resources :bookmarks, only: [:destroy]
end
