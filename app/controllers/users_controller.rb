class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
  def friend_feed
    @followee_list = current_user.followees
  end

  def search_friend
    if params[:friend].present?
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
          
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid friend to search"
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
