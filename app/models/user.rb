class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :followings
  has_many :followees, through: :followings
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

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  
  def self.matches(column_name, matching_pattern)
    where("#{column_name} like ?", "%#{matching_pattern}%")
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.search(param)
    search_results = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless search_results
    search_results
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    !self.followees.where(id: friend_id).exists?
  end
end
