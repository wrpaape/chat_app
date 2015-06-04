Rails.application.routes.draw do


  get 'chatrooms', to: 'chatrooms#index'

  get 'users', to: 'users#index'

  get 'messages', to: 'messages#index'

end
