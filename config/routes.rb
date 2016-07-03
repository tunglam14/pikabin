Rails.application.routes.draw do
  get '/404' => 'errors#not_found'

  root 'documents#new'

  get '/' => 'documents#new'
  post '/' => 'documents#create', as: 'document'
  get '/:token' => 'documents#show', :constraints => {:token => /.*/}

end
