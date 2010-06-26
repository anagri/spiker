share_examples_for 'authenticated user staff viewed and admin managed controller' do
  describe 'for guest' do
    before(:each) do
      @user = guest
      @allowed_actions = none_actions
    end

    it_should_behave_like 'authorized controller'
  end

  describe 'for staff' do
    before(:each) do
      @user = staff
      @allowed_actions = view_actions
    end

    it_should_behave_like 'authorized controller'
  end

  describe 'for admin' do
    before(:each) do
      @user = admin
      @allowed_actions = manage_actions
    end

    it_should_behave_like 'authorized controller'
  end
end