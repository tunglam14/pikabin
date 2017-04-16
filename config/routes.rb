Rails.application.routes.draw do
  get '/404' => 'errors#not_found', as: 'not_found'

  root 'documents#new'

  get '/' => 'documents#new'
  post '/' => 'documents#create', as: 'document'
  get '/:token' => 'documents#show', as: 'document_show'
  delete '/:token' => 'documents#destroy', as: 'document_destroy'

end
