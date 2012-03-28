require File.dirname(__FILE__) + '/spec_helper.rb'

describe AssociativeMemory do
  
  it "should have a valid version number" do
  	AssociativeMemory::VERSION.should match(/\d+\.\d+\.\d+/)
  end
  
  it "should build a convergent weight matrix from training data" do
  	training_data = [
  		{:in => [1, 0, 1, 0, 1, 0], :out => [1, 1, 0, 0]},
  		{:in => [1, 1, 1, 0, 0, 0], :out => [1, 0, 1, 0]},
  		{:in => [1, 0, 1, 1, 1, 1], :out => [1, 0, 0, 1]},
  		{:in => [0, 0, 0, 1, 1, 1], :out => [0, 1, 1, 0]},
  		{:in => [0, 1, 0, 1, 0, 1], :out => [0, 0, 1, 1]}
  	]

  end

end
