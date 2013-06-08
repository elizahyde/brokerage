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

  erb :portfolios
end

get "/stocks" do
  @stocks = Stock.all

  erb :stocks
end

post "/new_stock" do
  @stock = Stock.new(params[:stock])

  if @stock.save
    redirect "/stocks"
  else
    erb :new_stock
  end
end

post "/new_portfolio" do
  @portfolio = Portfolio.new(params[:portfolio])

  if @portfolio.save
    redirect "/portfolios"
  else
    erb :new_portfolio
  end
end

post "/save_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])

  if @portfolio.update_attributes(params[:portfolio])
    redirect "/portfolios"
  else
    erb :edit_portfolio
  end
end

get "/edit_portfolio/:portfolio_id" do
  @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  erb :edit_portfolio
end


post "/new_client" do
  @client = Client.new(params[:client])
  @portfolio = Portfolio.new(params[:portfolio])

  if @client.save

    @portfolio = Portfolio.find_or_create_by_sector(params[:portfolio][:sector])
    # This adds client ID to portfolio table.
    @portfolio.update_attributes(:client_id => @client.id)
    #Of This makes the stocks save! Then it broke stuff so I had to add the other lines.
    @portfolio.update_attributes(params[:portfolio])
    #this declares everything for portfolio (oh wait this is above. might be able to delete)
    @portfolio = Portfolio.new(params[:portfolio])


    redirect "/clients"
  else
    erb :new_client
  end
end


get "/edit_client/:client_id" do
  @client = Client.find_by_id(params[:client_id])
  erb :edit_client
end