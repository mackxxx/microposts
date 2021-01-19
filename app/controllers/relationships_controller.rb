class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followee_id])
    byebug
    @curent_user.follow(user)
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    unfollow(user)
    redirect_to user
  end
end