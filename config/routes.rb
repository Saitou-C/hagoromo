Rails.application.routes.draw do

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do#namespaceでurlにadminをつける
    get "/" => "homes#top"
  end

  # 顧客用
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  scope module: :user do
    root to: "homes#top"
    get "users/confirm_withdraw" => "users#confirm_withdraw"
    patch "users/withdraw" => "users#withdraw"
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:new, :create, :destroy, :index, :show]
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
