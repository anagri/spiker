module AuthorizedSharedSpecUtils
  def do_request(user, action)
    get_html_with user, action.to_sym, (instance_variable_get(:"@#{action}_params") || {:id => @resource_id})
  end
end

shared_examples_for "authorized controller" do
  include AuthorizedSharedSpecUtils
  before(:each) do
    @user ||= staff
  end

  it 'should not allow guest to access actions' do
    all_actions(controller.class).each do |action|
      do_request(guest, action)
      response.should (@unauthorized_access_expectation || be_unauthorized)
    end
  end

  it 'should allow user to access actions' do
    all_actions(controller.class).each do |action|
      do_request(@user, action)
      be_result, msg = action =~ /create/ ? [be_redirect, "authorization on #{controller.class}.#{action} failed"] : [be_success, "authorization on #{controller.class}.#{action} failed, #{response.body}"]
      response.should be_result, msg
    end
  end
end

shared_examples_for "unauthorized controller" do
  include AuthorizedSharedSpecUtils
  before(:each) do
    @user = staff
  end

  it 'should not allow users to access actions' do
    all_actions(controller.class).each do |action|
      do_request(@user, action)
      response.should redirect_to(dashboard_url)
    end
  end

  it 'should allow guest user on home' do
    all_actions(controller.class).each do |action|
      do_request(guest, action)
      response.should be_success
    end
  end
end
