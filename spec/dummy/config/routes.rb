Rails.application.routes.draw do
  mount PayuRails::Engine => "/payu_rails"

  namespace :steps do
    resources :payments, :only => :index
    resources :initialize_pays, :only => :new
  end

  root :to => "steps/payments#index"
end
