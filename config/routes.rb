Rails.application.routes.draw do
  root 'documents#new'
  get '/' => 'documents#new'
  post '/' => 'documents#create', as: 'document'
  get '/:token' => 'documents#show', :constraints => {:token => /.*/}
end
