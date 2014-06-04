require 'spec_helper'

describe AssociativeMemory do
	
	it "has a valid version" do
		expect(AssociativeMemory::VERSION).to match(/\d+\.\d+\.\d+/)
	end

	describe "providing some association pairs" do
		before do
			@animals = AssociativeMemory.new
			@animals.associate([:tail, :shell], [:turtles])
			@animals.associate([:arms, :legs], [:humans])
		end
		it "constructs a valid memory" do
			expect(@animals.valid?).to be true
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
		it "reconstructs things statically trained" do
			running_things = @animals.describe([:running])
			[:cats, :rats, :humans].each do |thing|
				expect(running_things).to include(thing)
			end
		end
		it "reconstructs things dynamically trained (over multiple learnings)" do
			expect(@animals.describe([:humans])).to eq([:arms, :legs, :running, :swimming])
			expect(@animals.describe([:swimming])).to eq([:fish, :humans, :rats, :turtles])
			expect(@animals.describe([:tail])).to eq([:cats, :fish, :rats, :turtles])
		end
		it "reconstructs generalizations from things not explicitly trained" do
			expect(@animals.describe([:fish])).to include(:tail)
		end
		it "dynamically re-associates patterns from existing data when further trained" do
			@animals.associate([:jumping], [:humans, :rats])
			expect(@animals.describe([:humans])).to include(:jumping)
		end
	end

	describe "data structure inspection" do
		before do
			@animals = AssociativeMemory.new
			@animals.associate([:tail, :fur, :legs, :paws], [:cats, :rats])
			@animals.associate([:fins, :swimming], 			[:fish])
			@inspection = @animals.pretty_inspect
		end
		it "includes labels of pairs, keyspaces, and the convergence network" do
			expect(@inspection).to match /associated_pairs/
			expect(@inspection).to match /input_keyspace/
			expect(@inspection).to match /output_keyspace/
			expect(@inspection).to match /convergence network/
		end
		it "includes the associative_memory object_id" do
			expect(@inspection).to match /associative_memory object: \d*/
		end
		it "includes output of trained keyspaces" do
			expect(@inspection).to match /[:fins, :fur, :legs, :paws, :swimming, :tail]/
			expect(@inspection).to match /[:cats, :rats, :fish]/
		end
		it "includes output of the convergence network" do
			expect(@inspection).to match /[-2, -2, 2]/
			expect(@inspection).to match /[2, 2, -2]/
		end
	end
end
