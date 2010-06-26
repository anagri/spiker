module AuthorizedSharedSpecUtils
  def do_request(user, action)
    get_html_with user, action.to_sym, (instance_variable_get(:"@#{action}_params") || {:id => @resource_id})
  end
end

shared_examples_for 'authorized controller' do
  include AuthorizedSharedSpecUtils
  before(:each) do
    @allowed_actions = (@allowed_actions || all_actions(controller.class)) & all_actions(controller.class)
    @restricted_actions = (@restricted_actions || (all_actions(controller.class) - @allowed_actions)) & all_actions(controller.class)
  end

  it 'should allow access to allowed actions' do
    @allowed_actions.each do |action|
      do_request(@user, action)
      be_result, msg = action =~ /create/ ? [be_redirect, "authorization on #{controller.class}.#{action} failed"] : [be_success, "authorization on #{controller.class}.#{action} failed"]
      response.should(instance_variable_get(:"@#{action}_expectation")|| be_result, msg)
    end
  end

  it 'should not allow access to restricted actions' do
    @restricted_actions.each do |action|
      do_request(@user, action)
      response.should(@unauthorized_access_expectation || be_unauthorized, "authorization on #{controller.class}.#{action} failed")
    end
  end
end
