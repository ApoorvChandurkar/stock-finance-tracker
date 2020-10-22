class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def count_under_limit?
      stocks.count < 10
  end

  def already_tracking?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false if stock.nil?
    
    !stocks.find_by(ticker: ticker_symbol).nil?
  end
  def can_track_stock?(ticker_symbol)
    count_under_limit? && !already_tracking?(ticker_symbol)
  end

end
