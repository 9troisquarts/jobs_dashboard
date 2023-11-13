JobsDashboard::Engine.routes.draw do
  root 'dashboard#index'

  resources :job_logs
end
