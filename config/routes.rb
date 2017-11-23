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

    resources :subscriptions do
      collection do
        post 'subscribe'
        post 'unsubscribe'
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
