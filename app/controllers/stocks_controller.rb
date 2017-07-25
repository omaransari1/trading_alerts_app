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

  # gives list of symbols based on popularity among users
  def popular_stocks
    #pluck to pull a column of values from a table
    @stocks = Stock.pluck(:symbol)
    # stock_counts is setting a new hash ready to accept new keys with default value 0
    @stock_counts = Hash.new 0
    @stocks.each do |stock|
      @stock_counts[stock] += 1
    end
    # @sorted_counts is a 2d array, each element of outer array has 2 elements pos 0 & 1
    @sorted_counts = @stock_counts.sort{|a,b| b[1] <=> a[1]}
    render "popular_stocks"
  end

  def new
    render 'new.html.erb'
  end

  def create
    @stock = Stock.new(
        symbol: params[:stocktoadd].upcase,
        user_id: current_user.id
      )

    if @stock.save
      flash[:success] = "#{@stock.symbol} added to watchlist successfully"
      redirect_to action: 'index'
    else
      flash[:error] = "#{@stock.errors.messages[:symbol][0]}"
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

  def stockprofile
    @symbol = params[:symbol]
    @yahoo_client = YahooFinance::Client.new
    @data = @yahoo_client.quotes(["#{@symbol}"], [:last_trade_price, :market_capitalization, :moving_average_50_day,
      :high_52_weeks, :low_52_weeks])

    render 'stockprofile.html.erb'
  end

  def destroy
    stocks_to_delete = Stock.where(symbol: params[:stocktodelete], user_id: current_user.id)
    stocks_to_delete.each do |stock|
      stock.destroy
    end

    flash[:notice] = "#{params[:stocktodelete]} removed from watchlist"

    redirect_to action: 'index'
  end
end