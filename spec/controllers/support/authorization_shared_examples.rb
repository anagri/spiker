# anamolies : testing only with get, whereas some action are mapped only for post (create), delete(destroy), put(update)
# not sure if calling from controller, only actions matter or routes and methods too

shared_examples_for "authorized controller" do
  before(:each) do
    @user = staff
  end

  it 'should not allow guest to access actions' do
    all_actions(@controller_class).each do |action|
      get_html_with guest, action.to_sym, :id => @resource_id
      response.should be_unauthorized
      response.should render_template('unauthorized')
      flash[:error].should == "#{@controller_class.name.decontrolled}.#{action}.unauthorized"
    end
  end

  it 'should allow user to access actions' do
    all_actions(@controller_class).each do |action|
      get_html_with @user, action.to_sym, :id => @resource_id
      response.should be_success
    end
  end
end

shared_examples_for "unauthorized controller" do
  before(:each) do
    @user = staff
  end

  it 'should not allow users to access actions' do
    all_actions(@controller_class).each do |action|
      get_html_with @user, action.to_sym, :id => @resource_id
      response.should redirect_to(dashboard_url)
    end
  end

  it 'should allow guest user on home' do
    all_actions(@controller_class).each do |action|
      get_html_with guest, action.to_sym
      response.should be_success
    end
  end
end
