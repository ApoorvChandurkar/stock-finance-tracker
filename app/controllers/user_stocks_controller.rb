class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.nil?
      stock = Stock.stock_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio."
    redirect_to my_portfolio_path
  end

  def destroy
    stock_id = params[:id]
    user_stock = UserStock.find_by(user_id: current_user.id, stock_id: stock_id)
    user_stock.destroy
    flash[:notice] = "#{Stock.find(stock_id).ticker} was successfully removed from your portfolio"
    redirect_to my_portfolio_path
  end
end
