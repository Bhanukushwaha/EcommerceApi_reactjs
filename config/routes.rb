Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope :api do
   get  '/students' =>  'students#student_search'
   resources :students
   resources :users
   post '/auth/login', :to => 'authentication#login'
  end
end
