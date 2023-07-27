Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :coaches, only: %i[index show create]
      resources :students, only: %i[index show create]
      resources :slots, only: %i[index create]
      resources :appointments, only: %i[create update]
    end
  end
end
