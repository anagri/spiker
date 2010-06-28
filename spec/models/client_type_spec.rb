require File.dirname(__FILE__) + '/spec_helper'

describe ClientType do
  describe 'roots' do
    before(:each) do
      @center = Factory.without_access_control_do_create(:client_type)
      @group = Factory.without_access_control_do_create(:client_type)
      @client = Factory.without_access_control_do_create(:client_type, :parents=> [@center, @group])
    end

    it 'should return roots' do
      ClientType.roots.should == [@center, @group]
    end
  end

  describe 'validation' do
    describe 'name validation' do
      before(:each) do
        @resource = ClientType.new
      end

      it_should_behave_like 'validates name'
    end
  end
end