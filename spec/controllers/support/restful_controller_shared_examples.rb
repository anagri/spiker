share_examples_for 'create with xhr support' do
  it 'should create and send successful message' do
    model_stub = stub('additional_attribute_stub', :save => true, :id => 1, :class => @model_class)
    @model_class.stubs(:new).returns(model_stub)
    get_html_with admin, :create, @create_params || {}
    response.should be_redirect_to(@redirect_url || send("#{@model_class.name.underscore}_url", model_stub))
  end

  it 'should render new if error while saving' do
    model_stub = stub("#{@model_class}_stub", :save => false, :id => 1, :class => @model_class)
    @model_class.stubs(:new).returns(model_stub)
    get_html_with admin, :create, @create_params || {}
    response.should be_unprocessible_entity
    response.should render_template('new')
  end
end