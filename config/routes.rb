Gatherer::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users
  root to: 'projects#index'
  
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end
  
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
