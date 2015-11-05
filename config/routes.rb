RedmineApp::Application.routes.draw do
  post '/shady_mode', to: 'shady#create', as: 'new_shady'
  delete '/shady_mode', to: 'shady#destroy', as: 'shady'
end
