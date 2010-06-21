class PasswordResetsController < ApplicationController
  filter_access_to :all
  before_filter :load_password_reset, :only => [:edit, :update]
  before_filter :new_password_reset_from_params, :only => [:create]

  def new
  end

  def create
    if @user
      # OPTIMIZE send out emails in parallel
      @user.without_access_control_do_deliver_password_reset_instructions!(:host => request.host, :port => request.port)
      flash[:info] = success_msg
      redirect_to root_url
    else
      flash[:error] = error_msg
      render :action => 'new'
    end
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.without_access_control_do_save
      flash[:info] = success_msg
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  def edit
  end

  private
  def new_password_reset_from_params
    @user = User.find_by_email(params[:email])
  end

  def load_password_reset
    @user = User.without_access_control_do_find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = error_msg
      redirect_to root_url
    end
  end
end