Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :questions, only: [:index] do
    post :answer, on: :member
  end

  get "history", to: "history#index", as: :history



  namespace :admin do
    root "dashboard#index"

    resources :questions

    resources :exam_boards, except: [:show]
    resources :institutions, except: [:show]
    resources :positions, except: [:show]
    resources :subjects, except: [:show]
    resources :topics, except: [:show]
    resources :exams, except: [:show]
  end

end