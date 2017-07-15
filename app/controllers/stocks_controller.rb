class StocksController < ApplicationController
  def index

    @user_stocks = Stock.where(user_id: current_user)
    @user_stock_symbols = @user_stocks
    @yahoo_client = YahooFinance::Client.new
    @data = @yahoo_client.quotes(['PCLN', 'AMZN','AAPL'], [:last_trade_price, :moving_average_50_day,
      :high_52_weeks])
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @stock = Stock.create(
        symbol: params[:stocktoadd],
        user_id: current_user.id
      )

  end

  def watchlist_item

    @my_symbol = params[:my_symbol]
    @yahoo_client = YahooFinance::Client.new
    @data = @yahoo_client.quotes(["#{@my_symbol}"], [:last_trade_price,:moving_average_50_day,
      :high_52_weeks])

    render '/stocks/watchlist_item.html.erb'
  end
end