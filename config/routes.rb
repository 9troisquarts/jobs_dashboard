JobsDashboard::Engine.routes.draw do
  root 'job_logs#index'
  resources :job_logs
end
