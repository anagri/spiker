class PasswordResetsController < ApplicationController
  filter_resource_access

  layout 'full_page'

  def new
  end

  def create
    if @password_reset.valid?
      # OPTIMIZE send out emails in parallel
      @password_reset.user.without_access_control_do_deliver_password_reset_instructions!(:host => request.host, :port => request.port)
      flash_success_msg
      redirect_to root_url
    else
      flash_error_msg
      render :action => 'new'
    end
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.validate_password_for_reset? && @user.without_access_control_do_save
      flash_success_msg
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  def edit
  end

  protected
  def new_password_reset_from_params
    @password_reset = PasswordReset.new(params[:password_reset])
  end

  def load_password_reset
    @password_reset = PasswordReset.new # for declarative authorization so that does not load from database
    @user = User.without_access_control_do_find_using_perishable_token(params[:id])
    unless @user
      flash_error_msg(true)
      redirect_to root_url
    end
  end
end