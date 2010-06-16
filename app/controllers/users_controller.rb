class UsersController < ApplicationController
  filter_resource_access
  restrict_attributes_update [:username, :email]

  # otherwise the spec throws error saying 'no id given'
  def new
  end

  def create
    if @user.save
      flash[:info] = '.success'
      respond_to do |format|
        format.xml { head :created, :location => user_path(@user) }
        format.html { redirect_to user_path(@user) }
      end
    else
      flash[:error] = '.error'
      render :action => 'new'
    end
  end

  def edit
    render :action => 'new'
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:info] = '.success'
      redirect_to @user
    else
      render :action => 'edit'
      flash[:error] = '.error'
    end
  end
end
