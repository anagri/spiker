share_examples_for 'create with xhr support' do
  it 'should create and send successful message' do
    model_stub = stub('additional_attribute_stub', :save => true, :id => 1, :class => @model_class)
    @model_class.expects(:new).returns(model_stub)
    get_html_with admin, :create
    response.should be_redirect_to(send("#{@model_class.name.underscore}_url", model_stub))
  end

  it 'should render new if error while saving' do
    model_stub = stub("#{@model_class}_stub", :save => false, :id => 1, :class => @model_class)
    @model_class.expects(:new).returns(model_stub)
    get_html_with admin, :create
    response.should be_success
    response.should render_template('new')
  end
end