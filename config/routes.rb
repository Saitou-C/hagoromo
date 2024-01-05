Rails.application.routes.draw do

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do#namespaceでurlにadminをつける
    get "/" => "users#index"
    resources :users, only: [:show, :destroy] do
      member do
        get :post_index
        get :post_comment_index
      end
    end
    resources :posts, only: [:destroy] do
      resources :post_comments, only: [:destroy]
    end
  end

  # ユーザー用
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  scope module: :user do
    root to: "posts#index"
    get "confirm_withdraw" => "users#confirm_withdraw"
    get "/users" => redirect("/users/sign_up") #新規登録失敗後sign_upにリロード
    get "/posts" => redirect("posts/new") #新規投稿失敗後posts/newにリロード
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do #どのユーザーがいいねしたか判別するのにidが必要のためmemberを使う
        get :favorites
      end
    end

    resources :posts, only: [:new, :create, :destroy, :show] do
      resources :post_comments, only: [:create, :destroy] #postsに結びつく親子関係のため
      resource :favorite, only: [:create, :destroy] #resource(単数形)にすると/:idがURLに含まれなくなる
    end
    get '/search', to: 'searches#search'
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
