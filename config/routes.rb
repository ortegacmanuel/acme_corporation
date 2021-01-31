Rails.application.routes.draw do
  mount RailsEventStore::Browser => '/res' if Rails.env.development?
  
  namespace :lead_generation do
    resources :leads, only: [:index, :create]
    resources :qualified_leads, only: [:create]
  end

  root to: "lead_generation/leads#index"
end
