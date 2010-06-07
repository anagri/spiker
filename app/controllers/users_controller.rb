class UsersController < ApplicationController
  filter_resource_access
  restrict_attributes_update [:username, :email]

  def create
    if @user.save
      flash[:notice] = 'Registration Successful'
      head :created, :location => user_path(@user)
    else
      render :action => 'new'
    end
  end

  def edit
    render :action => 'new'
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to user_path(@user)
    else
      render :action => 'edit'
    end
  end
end
