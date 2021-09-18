Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'events', to: 'events#events'
  # resources :events, only: [] do
  #   collection do
  #     get :events
  #   end
  # end
end
