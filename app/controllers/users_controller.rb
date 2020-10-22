class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end
  def friend_feed
    @followee_list = current_user.followees
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search_friend
    if params[:friend].present?
      @friend_list = User.search(params[:friend])
      @friend_list = current_user.except_current_user(@friend_list)
      if !@friend_list.empty?
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
          
      else
        respond_to do |format|
          flash.now[:alert] = "No results found for given query"
          format.js { render partial: 'users/friend_result' }
        end
                
      end

      
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a name or an email to search"
        format.js { render partial: 'users/friend_result' }
      end
      
      
    end
  end
end
