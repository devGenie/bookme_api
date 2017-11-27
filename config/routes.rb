Rails.application.routes.draw do
  apipie
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
        post 'return/:borrowed_id', to: 'books#return'
      end
      member do
        post 'subscriber/:subscription_id/borrow/:collection_id', to: 'books#borrow'
      end
    end

    resources :subscriptions do
      collection do
        post 'subscribe'
      end
      member do
        delete 'unsubscribe'
      end
    end
  end

  resources :authors do
    collection do
    end
  end

  resources :categories do
    collection do
    end
  end
end
