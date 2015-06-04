Rails.application.routes.draw do
  get 'todos/new', to: 'todos#new'

  get 'todos/:id', to: 'todos#show'

  put 'todos/:id', to: 'todos#update'

  delete 'todos/:id', to: 'todos#destroy'

  get 'todos', to: 'todos#index'

  post 'todos', to: 'todos#create'



end
