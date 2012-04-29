Postwire::Application.routes.draw do
  resources :stories do
    resources :versions
  end
end
