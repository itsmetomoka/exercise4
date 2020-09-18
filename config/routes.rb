Rails.application.routes.draw do
	root 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  resources :users, only: [:show, :edit, :update, :create, :index]
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
 	end
 	put 'users/follow/:user_id' => 'users#follow'
	put 'users/unfollow/:user_id' => 'users#unfollow'
	#フォローとフォローを外すアクション

	get 'users/follow_list/:user_id' => 'users#follow_list'
	get 'users/follower_list/:user_id' => 'users#follower_list'
	#フォロー・フォロワーの一覧ページ
end
