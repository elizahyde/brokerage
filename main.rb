require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative "db_info"

require_relative "client"
require_relative "portfolio"
require_relative "stock"

get "/" do
  @clients = Client.all
  @portfolios = Portfolio.all
  @stocks = Stock.all
  erb :index
end

get "/new_client" do
  erb :new_client
end

get "/new_stock" do
  erb :new_stock
end

get "/new_portfolio" do
  erb :new_portfolio
end