require 'spec_helper'

describe AssociativeMemory do
	
	it "should have a valid version number" do
		AssociativeMemory::VERSION.should match(/\d+\.\d+/)
	end
	
	it "should pass method calls through to the network class" do
	end

end
