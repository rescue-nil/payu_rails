PayuRails::Engine.routes.draw do
  resources :access_tokens, :only => :new
end
