share_examples_for 'validates name' do
  it 'should not be valid if name is nil' do
    @resource.name= nil
    @resource.should have_ar_errors(:name => :blank)
  end

  it 'should not be valid if name is blank' do
    @resource.name= ''
    @resource.should have_ar_errors(:name => :blank)
  end

  it 'should not be valid if name is more than 30 chars' do
    @resource.name= 'a'*31
    @resource.should have_ar_errors(:name => :too_long)
  end

  it 'should not be valid if name is non-blank less than 30 chars' do
    @resource.name= 'a'*30
    @resource.should be_valid
  end

  it 'should validate uniqueness of name' do
    Authorization::Maintenance.without_access_control do
      @resource.name = 'valid_name'
      duplicate_existing_record = @resource.class.create(@resource.attributes)
      @resource.should have_ar_errors(:name => :taken)
    end
  end
end