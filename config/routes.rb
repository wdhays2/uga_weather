# frozen_string_literal: true

Rails.application.routes.draw do
  root 'weather_results#show'
  resource :weather_results, only: [:show]
end
