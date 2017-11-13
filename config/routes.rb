Rails.application.routes.draw do
  resources :users do
    collection do
      get 'login'
    end
  end
end
