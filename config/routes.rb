Rails.application.routes.draw do
  resources :users do
    collection do
      post 'login'
      post 'logout'
      get  'subscriptions'
      get  'borrowed_books'
    end
  end
end
