class UsersController < ApplicationController
  filter_resource_access
  restrict_attributes_update [:username, :email]

  def create
    if @user.save
      flash[:notice] = 'Registration Successful'
      head :created, :location => user_path(@user)
    else
      flash[:error] = 'Error while doing registration'
      render :action => 'new'
    end
  end

  def edit
    render :action => 'new'
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to :action => 'show', :id => @user.id, :only_path => true #make a extension only_path(@object|Hash|String), buggy rails implementation
    else
      render :action => 'edit'
    end
  end
end
