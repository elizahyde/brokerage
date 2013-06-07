require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require "stock_quote"

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

get "/clients" do
  @clients = Client.all
  @portfolios = Portfolio.all
  @stocks = Stock.all

  #portfolio.sector if portfolio.client_id

  erb :clients
end

get "/portfolios" do
  @clients = Client.all
  @portfolios = Portfolio.all
  @stocks = Stock.all
# <%= portfolio.stocks.map {|stock| stock.symbol }.join(", ") %>
  erb :portfolios
end

get "/stocks" do
  @stocks = Stock.all

  erb :stocks
end

post "/new_stock" do
  @stock = Stock.new(params[:stock])

  if @stock.save
    redirect "/"
  else
    erb :new_stock
  end
end

post "/save_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])

  if @portfolio.update_attributes(params[:portfolio])
    redirect "/"
  else
    erb :edit_portfolio
  end
end

get "/edit_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  erb :edit_portfolio
end


post "/new_client" do
  @client = Client.new(:name => params[:client_name],
    :retirement => params[:client_retirement],
    :zipcode => params[:client_zipcode]
    )

  if @client.save
    @portfolio = Portfolio.create(:sector => params[:portfolio][:sector], :client_id => @client.id)

    redirect "/"
  else
    erb :new_client
  end
end


get "/edit_client/:client_id" do
  @client = Client.find_by_id(params[:client_id])
  erb :edit_client
end