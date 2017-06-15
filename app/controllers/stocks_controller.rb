class StocksController < ApplicationController
  def index
    @yahoo_client = YahooFinance::Client.new
    @data = @yahoo_client.quotes(['PCLN', 'AMZN','AAPL'], [:ask, :bid, :last_trade_date])
    render 'index.html.erb'
  end
end