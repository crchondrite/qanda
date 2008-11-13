ActionController::Routing::Routes.draw do |map|
  map.root :controller => "questions"
  map.resource :session

  map.resources :questions do |question|
    question.resources :answers
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
