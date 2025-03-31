# config.ru
require_relative './app/routes/api'
run API.new