class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
