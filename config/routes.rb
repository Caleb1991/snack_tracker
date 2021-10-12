Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        get '/snacks/top_rated_snacks', to: '/api/v1/users/snacks#top_rated_snacks'
        resources :snacks, only: :index, to: '/api/v1/users/snacks#index' do
        end

      end
      get '/snacks/average_rating'
      resources :snacks
      resources :users_snacks, only: [:create, :destroy]
      resources :reviews, only: [:create, :update, :destroy]
    end
  end
end
