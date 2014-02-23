Sync::Application.routes.draw do

  get 'tags/:tag' , to: 'projects#index' , as: :tag
  
  resources :projects do
    member do
      get :sync
    end
    
    collection do
      post :search
    end
  end
  
  root to: 'projects#index'
end
