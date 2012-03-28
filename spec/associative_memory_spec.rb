require File.dirname(__FILE__) + '/spec_helper.rb'

describe AssociativeMemory do
  
  it "should have a valid version number" do
  	AssociativeMemory::VERSION.should match(/\d+\.\d+\.\d+/)
  end
  
end
