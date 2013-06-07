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

post "/new_stock" do
  @stock = Stock.new(params[:stock])

  if @stock.save
    redirect "/"
  else
    erb :new_stock
  end
end

post "/new_portfolio" do
  @portfolio = Portfolio.new(:sector => params[:portfolio][:sector], :client_id => params[:portfolio][:client_id])

  if @portfolio.save
    redirect "/"
  else
    erb :new_portfolio
  end
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