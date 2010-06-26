class UsersController < ApplicationController
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
        format.html { redirect_to user_path(@user) }
        format.xml { head :created, :location => user_path(@user) }
      end
    else
      flash[:error] = error_msg
      render :action => 'new'
    end
  end

  def edit
    render :action => 'new'
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:info] = success_msg
      redirect_to @user
    else
      render :action => 'edit'
      flash[:error] = error_msg
    end
  end
end
