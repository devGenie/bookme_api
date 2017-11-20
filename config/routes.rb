Rails.application.routes.draw do
  resources :users do
    collection do
      post 'login'
      post 'logout'
      get  'subscriptions'
      get  'borrowed_books'
    end
  end

  resources :libraries do
    collection do
    end
    resources :books do
      collection do
      end
    end
  end
end
