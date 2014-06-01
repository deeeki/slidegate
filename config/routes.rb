Rails.application.routes.draw do
  root 'slides#index'
  get ':year/:month/:day' => 'slides#index', year: /\d{4}/, month: /\d{2}/, day: /\d{2}/
end
