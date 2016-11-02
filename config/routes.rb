Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: 'home#public'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  get '/' => 'home#public'
  get '/words' => 'home#public'
  get '/word' => 'home#public'
  get '/radical' => 'home#public'
  get '/kanji/edit' => 'home#public'
  get '/kanji/write' => 'home#public'
  get '/kanji/example' => 'kanjis#example'
  get '/kanji/n4words' => 'kanjis#n4words'

  resources :words, only: [:show]
  resources :settings do
    get 'reader', on: :collection
  end

  scope "/api/v1" do
    resources :words, :defaults => { :format => 'json' } do
      collection do
        put 'sync'
      end
      get 'search', on: :collection
      get 'lesson', on: :collection
    end
    resources :radicals, :defaults => { :format => 'json' } do
    end

    resources :kanjis, :defaults => { :format => 'json' } do

    end

    resources :sentences, :defaults => { :format => 'json' } do
    end
    resources :settings, :defaults => { :format => 'json' } do
    end
    resources :shadows, :defaults => { :format => 'json' } do
    end
    resources :randoms, :defaults => { :format => 'json' } do
      get 'quiz', on: :collection
      get 'minakotoba', on: :collection
      get 'boost', on: :collection
      get 'read', on: :collection
      post 'slack', on: :collection
    end

    resources :grammars, only: [:show]

  end
end
