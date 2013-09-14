Jehddit::Application.routes.draw do
  
  get 'help', to: "static_pages#help"
  get 'about', to: "static_pages#about"
  get 'contact', to: "static_pages#contact"

  get 'signin', to: "sessions#new"
  delete 'signout', to: "sessions#destroy"
  get '/posts/:post_id/comments/:comment_id/reply', to: "comments#reply", as: 'reply'
  delete 'destroycomment', to: "comments#destroy"
  
  patch '/posts/:id/downvote', to: "posts#downvote", as: "downvote_post"
  patch '/posts/:id/upvote', to: "posts#upvote", as: "upvote_post"
  patch '/posts/:post_id/comments/:comment_id/upvote', to: "comments#upvote",
                                                       as: :upvote_comment
  patch '/posts/:post_id/comments/:comment_id/downvote', to: "comments#downvote",
                                                       as: :downvote_comment                                                     

  get '/users/:user_id/message', to: "messages#new", as: :new_message
  get '/messages', to: "messages#index", as: :messages                                                    

  resources :users do
    resources :messages, only: [:new, :create, :destroy, :show, :index]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts do
    resources :comments, only: [:new, :create, :show, :destroy] do
      resources :comments, only: [:create, :show]
    end
  end

  root "static_pages#home"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
end
