class StocksController < ApplicationController
  def search
    @stock = Stock.stock_lookup(params[:stock])
    render 'users/my_portfolio'
  end
end