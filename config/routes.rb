# frozen_string_literal: true

Rails.application.routes.draw do
  root 'readings#show'
  resource :readings, only: [:show]
  resource :charts, only: [:show]
end
