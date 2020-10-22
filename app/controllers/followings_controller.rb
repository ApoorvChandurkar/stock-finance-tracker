class FollowingsController < ApplicationController
  def create
    new_following = Following.new(user_id: current_user.id, followee_id: params[:friend])
    new_following.save

    flash[:notice] = "Started following #{User.find(params[:friend]).full_name}"
    redirect_to friend_feed_path

  end

  def destroy
    to_be_unfollowed = Following.find_by(user_id: current_user.id, followee_id: params[:id])
    to_be_unfollowed.destroy
    flash[:notice] = "Stopped following #{User.find(params[:id]).full_name}"
    redirect_to friend_feed_path
  end
end
