class DashboardController < ApplicationController
  before_filter :load_user, :only => :index
  def index; end
end