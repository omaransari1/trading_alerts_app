class StocksController < ApplicationController
  def index

    @user_stocks = Stock.where(user_id: current_user.id)
    @user_stock_symbols = []
    @user_stocks.each do |stock|
      @user_stock_symbols << stock.symbol
    end

    @yahoo_client = YahooFinance::Client.new
    @data = @yahoo_client.quotes(@user_stock_symbols, [:last_trade_price, :moving_average_50_day,
      :high_52_weeks])
    render 'watchlist.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @stock = Stock.new(
        symbol: params[:stocktoadd],
        user_id: current_user.id
      )

    if @stock.save
      redirect_to action: 'index'
    else
      render 'new.html.erb'
    end

  end

  def watchlist_item

    @my_symbol = params[:my_symbol]
    @yahoo_client = YahooFinance::Client.new
    @data = @yahoo_client.quotes(["#{@my_symbol}"], [:last_trade_price,:moving_average_50_day,
      :high_52_weeks])

    render '/stocks/watchlist_item.html.erb'
  end

  def destroy
    stocks_to_delete = Stock.where(symbol: params[:stocktodelete], user_id: current_user.id)
    stocks_to_delete.each do |stock|
      stock.destroy
    end

    redirect_to action: 'index'
  end
end