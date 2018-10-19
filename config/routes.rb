Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  #post 'registration', to: 'users#registration'
  #post 'resend', to: 'users#resend'
  get 'info', to: 'info#show'
  post 'send', to: 'orders#create'
  get 'show', to: 'orders#show'
  get 'goods', to: 'goods#list'
  get 'goods/:id', to: 'goods#image'
  get 'invoices', to: 'invoice#get_invoices'
  get 'arved', to: 'invoice#get_arved'
end
