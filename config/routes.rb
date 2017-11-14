Rails.application.routes.draw do
  resources :users do
    collection do
      post 'login'
      post 'logout'
    end
  end
end
