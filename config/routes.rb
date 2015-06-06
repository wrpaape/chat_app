Rails.application.routes.draw do



  get 'chatrooms/new', to: 'chatrooms#new'
  get 'chatrooms/active', to: 'chatrooms#active'
  get 'chatrooms/:id/contents', to: 'chatrooms#contents'
  get 'chatrooms/:id/users', to: 'chatrooms#users'
  post 'chatrooms/:id/leave', to: 'chatrooms#leave'
  post 'chatrooms/:id/join_room', to: 'chatrooms#join_room'
  post 'chatrooms/:id/join', to: 'chatrooms#join'
  get 'chatrooms/:id', to: 'chatrooms#show'
  put 'chatrooms/:id', to: 'chatrooms#update'
  delete 'chatrooms/:id', to: 'chatrooms#destroy'
  get 'chatrooms', to: 'chatrooms#index'
  post 'chatrooms', to: 'chatrooms#create'

  get 'messages/new', to: 'messages#new'
  get 'messages/:id', to: 'messages#show'
  post 'messages/:id', to: 'messages#update'
  delete 'messages/:id', to: 'messages#destroy'
  get 'messages', to: 'messages#index'
  post 'messages', to: 'messages#create'

  get 'users/new', to: 'users#new'
  get 'users/leaderboard', to: 'users#leaderboard'
  get 'users/:id/message_history', to: 'users#messages'
  post 'users/:id/settings/delete', to: 'users#settings_delete'
  post 'users/:id/settings/add', to: 'users#settings_add'
  get 'users/:id', to: 'users#show'
  post 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
  get 'users', to: 'users#index'
  post 'users', to: 'users#create'

  match '*not_found_route', to: 'application#not_found', via: [:get, :post, :put, :delete]
end
