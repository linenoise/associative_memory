require 'spec_helper'

describe AssociativeMemory do
	
	it "should have a valid version number" do
		AssociativeMemory::VERSION.should match(/\d+\.\d+/)
	end

	describe "providing some assoiation pairs" do
		before do
			@animals = AssociativeMemory.new
			@animals.associate([:tail, :shell], [:turtles])
			@animals.associate([:arms, :legs], [:humans])
		end
		it "should construct a valid memory" do
			@animals.valid?.should be_true
		end
	end

	describe "describing a memory" do
		before do
			@animals = AssociativeMemory.new
			@animals.associate([:tail, :fur, :legs, :paws], [:cats, :rats])
			@animals.associate([:fins, :swimming], 			[:fish])
			@animals.associate([:tail, :shell], 			[:turtles])
			@animals.associate([:arms, :legs], 				[:humans])
			@animals.associate([:swimming], 				[:humans, :rats, :turtles])
			@animals.associate([:running], 					[:humans, :rats, :cats])
		end
		it "should reconstruct things statically trained" do
			running_things = @animals.describe([:running])
			[:cats, :rats, :humans].each do |thing|
				running_things.should include(thing)
			end
		end
		it "should reconstruct things dynamically trained (over multiple learnings)" do
			@animals.describe([:humans]).should == [:arms, :legs, :running, :swimming]
			@animals.describe([:swimming]).should == [:fish, :humans, :rats, :turtles]
			@animals.describe([:tail]).should == [:cats, :fish, :rats, :turtles]
		end
		it "should reconstruct generalizations from things not explicitly trained" do
			@animals.describe([:fish]).should include(:tail)
		end
		it "should dynamically reassociate patterns from existing data when further trained" do
			@animals.associate([:jumping], [:humans, :rats])
			@animals.describe([:humans]).should include(:jumping)
		end
	end

	describe "data structure inspection" do
		before do
			@animals = AssociativeMemory.new
			@animals.associate([:tail, :fur, :legs, :paws], [:cats, :rats])
			@animals.associate([:fins, :swimming], 			[:fish])
			@inspection = @animals.pretty_inspect
		end
		it "should include labels of pairs, keyspaces, and the convergence network" do
			@inspection.should match /associated_pairs/
			@inspection.should match /input_keyspace/
			@inspection.should match /output_keyspace/
			@inspection.should match /convergence network/
		end
		it "should include the associative_memory object_id" do
			@inspection.should match /associative_memory object: \d*/
		end
		it "should include output of trained keyspaces" do
			@inspection.should match /[:fins, :fur, :legs, :paws, :swimming, :tail]/
			@inspection.should match /[:cats, :rats, :fish]/
		end
		it "should include output of the convergence network" do
			@inspection.should match /[-2, -2, 2]/
			@inspection.should match /[2, 2, -2]/
		end
	end
end
