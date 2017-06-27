Rails.application.routes.draw do
  get 'pages/index' => 'pages#index'
  get 'services/:service' => 'pages#services'
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'

  root 'pages#index'
end
