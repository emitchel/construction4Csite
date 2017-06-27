Rails.application.routes.draw do
  get 'pages/index' => 'pages#index'
  get 'services/:service' => 'pages#services'
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'

  resources :pages, only: [] do
    collection do
      post :send_contact
    end
  end

  root 'pages#index'
end
