# frozen_string_literal: true

Rails.application.routes.draw do
  root 'results#show'
  resource :results, only: [:show]
end
