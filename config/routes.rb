Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    }

    resources :home do
      collection do
        get 'users_details', to: 'home#user_show'
      end

      member do
        get 'edit_user', to: 'home#edit_user'
        patch 'update_user ', to: 'home#update_user'
        delete 'destroy_user', to: 'home#destroy_user'
      end
    end

  root 'home#index' 
  
  resources :allotments do
    member do
      get 'deallot'
    end
  end

  resources :brands
  resources :categories

  resources :items do
    member do
      get 'allotments'
      get 'managestock', to: 'items#manage_item_stock'
      patch 'updatestock', to: 'items#update_stock'
    end
  end

end
