Rails.application.routes.draw do



  get 'chatrooms/new', to: 'chatrooms#new'
  put 'chatrooms/:id/join', to: 'chatrooms#join'
  get 'chatrooms/:id/contents', to: 'chatrooms#contents'
  get 'chatrooms/:id', to: 'chatrooms#show'
  put 'chatrooms/:id', to: 'chatrooms#update'
  delete 'chatrooms/:id', to: 'chatrooms#destroy'
  get 'chatrooms', to: 'chatrooms#index'
  post 'chatrooms', to: 'chatrooms#create'

  get 'messages/new', to: 'messages#new'
  get 'messages/:id', to: 'messages#show'
  put 'messages/:id', to: 'messages#update'
  delete 'messages/:id', to: 'messages#destroy'
  get 'messages', to: 'messages#index'
  post 'messages', to: 'messages#create'

  get 'users/new', to: 'users#new'
  get 'users/:id', to: 'users#show'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'
  get 'users', to: 'users#index'
  post 'users', to: 'users#create'


end
