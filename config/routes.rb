PayuRails::Engine.routes.draw do
  resources :commissions, :only => [:index, :update]
  resources :commission do
    resources :access_tokens, :only => :new
    resources :completes, :only => :new
    resources :cancels, :only => :new
    resources :statuses, :only => :create
  end
end
