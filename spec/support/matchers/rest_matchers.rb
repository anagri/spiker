Spec::Matchers.define :have_created_resource do |resource, location|
  match do |response|
    resource.should_not be_nil
    response.should be_success
    response.code.should == "201"
    response.location.should == location
  end

  failure_message_for_should do |response|
    message = "expectation failed for unknown reason"
    message = "expected the resource to be non nil but was nil" if resource.nil?
    message = "expected the response to be success but was #{response.code}" unless response.success?
    message = "expected the response code to be created(201) but was #{response.code}" unless response.code == 201
    message = "expected the response location to be #{location} but was #{response.location}" unless response.location == location
    message
  end

  failure_message_for_should_not do |actual|
    "expected that request would not create response"
  end

  description do
    "create a resource by restful request"
  end
end

Spec::Matchers.define :have_updated_resource do |resource, location|
  match do |response|
    resource.should_not be_nil
    response.should be_redirect
    response.code.should == "302"
    response.location.should == location
  end

  failure_message_for_should do |response|
    message = "expectation failed for unknown reason"
    message = "expected the resource to be non nil but was nil" if resource.nil?
    message = "expected the response code to be redirect(302) but was #{response.code}" unless response.code == "302"
    message = "expected the response location to be #{location} but was #{response.location}" unless response.location == location
    message
  end

  failure_message_for_should_not do |actual|
    "expected that request would not create response"
  end

  description do
    "create a resource by restful request"
  end
end

