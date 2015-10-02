Rails.application.routes.draw do
  namespace :api do
    get '/search', to: 'search#get', as: :search
  end
end
