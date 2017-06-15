class StocksController < ApplicationController
  def index
    @yahoo_client = YahooFinance::Client.new
    @data = @yahoo_client.quotes(['PCLN', 'AMZN','AAPL'], [:ask, :bid, :moving_average_50_day,
      :high_52_weeks])
    render 'index.html.erb'
  end
end