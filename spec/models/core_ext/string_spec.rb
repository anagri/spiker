describe String do
  it 'should give modelize name' do
    "Admin::UsersController".modelize.should == :user
  end
end