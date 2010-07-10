require File.dirname(__FILE__) + '/spec_helper'

describe FormHelper do
  it 'should return submit caption as create if record is new' do
    helper.stubs(:t).with('view.records.create', :default => :'view.common.create').returns('Build')
    helper.submit_caption(stub('record', :new_record? => true, :class => stub('RecordClass', :name => 'Record'))).should == 'Build'
  end

  it 'should return submit caption as create if record is persisted' do
    helper.stubs(:t).with('view.records.update', :default => :'view.common.update').returns('Do Update')
    helper.submit_caption(stub('record', :new_record? => false, :class => stub('RecordClass', :name => 'Record'))).should == 'Do Update'
  end
end