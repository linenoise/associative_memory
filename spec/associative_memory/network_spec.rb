require 'spec_helper'

describe AssociativeMemory::Network do
  context "when hetero-associative" do
  	before do
	  	training_data = [
	  		{:in => [1, 0, 1, 0, 1, 0], :out => [1, 1, 0, 0]},
	  		{:in => [1, 1, 1, 0, 0, 0], :out => [1, 0, 1, 0]},
	  		{:in => [1, 0, 1, 1, 1, 1], :out => [1, 0, 0, 1]},
	  		{:in => [0, 0, 0, 1, 1, 1], :out => [0, 1, 1, 0]},
	  		{:in => [0, 1, 0, 1, 0, 1], :out => [0, 0, 1, 1]}
	  	]
	  end
	  describe "a new neural network" do
	  	before do
		  	@network = AssociativeMemory.new
		  end
		  it "should be a kind of associative memory network" do
		  	@network.should be_a_kind_of(AssociativeMemory::Network)
		  end
		  it "should be empty" do
		  	@network.empty?.should be_true
		  end
		  it "should be well-structured" do
		  	@network.valid?.should be_true
		  end
		end

		describe "training a network" do
		  it "should build a convergence matrix from training data"
		end

	end

	# context "when auto-associative" do
	# 	before do
	# 		training_data = [
	# 			[1, 0, 1, 0, 1, 0],
	# 			[1, 1, 1, 0, 0, 0],
	# 			[1, 0, 1, 1, 1, 1],
	# 			[0, 0, 0, 1, 1, 1],
	# 			[0, 1, 0, 1, 0, 1]
	# 		]
	# 	end

	# 	it "should build a convergent weight matrix from training data"
	# end

end
