class UsersController < ApplicationController
  before_action :set_date_from_select
  def users
    @user = User.find_by(username: params[:username])
    @invalid_user = true if @user.nil? && params[:username].present?
    @event_dates = Event.between_dates(@starttime, @endtime).with_user_attending(@user).order(:starttime).pluck(:starttime, :endtime) unless @user.nil?
  end
end