# frozen_string_literal: true

Rails.application.routes.draw do
  get 'readings/index'
  get 'readings/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'readings#index'
end
