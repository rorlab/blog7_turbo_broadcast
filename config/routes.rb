Rails.application.routes.draw do
  root "pages#home"
  get "/about", to: "pages#about"
  resources :posts do
    resources :comments, only: [:create, :update, :destroy, :edit]
  end
end
