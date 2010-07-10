class UsersController < ApplicationController
  before_filter :load_user_for_edit_profile, :only => :edit_profile
  filter_resource_access
  restrict_attributes_update [:username, :email, :role, :office]

  # otherwise the spec throws error saying 'no id given'
  def index
    @users = User.all
  end

  def new; end

  def show; end

  def create
    if @user.save
      flash[:info] = success_msg
      respond_to do |format|
        format.html { redirect_to @user }
        format.xml { head :created, :location => user_path(@user) }
      end
    else
      flash[:error] = error_msg
      render :action => 'new', :status => :unprocessable_entity
    end
  end

  def edit
    render :action => 'new'
  end

  def edit_profile
    render :action => 'new'
  end

  def update
    if @user.update_attributes(params[:user])
      Session.create(current_user)
      flash[:info] = success_msg
      redirect_to @user
    else
      flash[:error] = error_msg
      render :action => 'new', :status => :unprocessable_entity
    end
  end

  protected
  def load_user_for_edit_profile
    params[:id] = current_user.try(:id).to_s
  end
end
