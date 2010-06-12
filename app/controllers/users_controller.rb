class UsersController < ApplicationController
  filter_resource_access
  restrict_attributes_update [:username, :email]

  # otherwise the spec throws error saying 'no id given'
  def new
  end

  def create
    if @user.save
      flash[:notice] = 'Registration Successful'
      respond_to do |format|
        format.xml { head :created, :location => user_path(@user) }
        format.html { redirect_to user_path(@user) }
      end
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
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
end
