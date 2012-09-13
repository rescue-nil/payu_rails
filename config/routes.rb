PayuRails::Engine.routes.draw do
  resources :commission do
    resources :access_tokens, :only => :new
    resources :completes, :only => :new
    resources :cancels, :only => :create
    resources :statuses, :only => :create
  end
end
