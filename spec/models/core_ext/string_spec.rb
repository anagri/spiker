describe String do
  it 'should give modelize name' do
    "Admin::UsersController".modelize.should == :user
  end

  it 'should convert to time' do
    "1.days.ago".convert_to_time.to_s.should == "1".to_i.send(:days).send(:ago).to_s
  end
end