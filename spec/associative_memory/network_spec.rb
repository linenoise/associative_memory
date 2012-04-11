require 'spec_helper'

describe AssociativeMemory::Network do
  context "when hetero-associative," do
  	let(:training_data) {
			[
	  		{:input => [1, 0, 1, 0, 1, 0], :output => [1, 1, 0, 0]},
	  		{:input => [1, 1, 1, 0, 0, 0], :output => [1, 0, 1, 0]},
	  		{:input => [1, 0, 1, 1, 1, 1], :output => [1, 0, 0, 1]},
	  		{:input => [0, 0, 0, 1, 1, 1], :output => [0, 1, 1, 0]},
	  		{:input => [0, 1, 0, 1, 0, 1], :output => [0, 0, 1, 1]}
	  	]  	
	 	}
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
	  	before do
		  	@network = AssociativeMemory.new
		  end
		  it "should build a valid convergence matrix from a single data point" do
	  		@network.learn(training_data[0][:input], training_data[0][:output])
		  	@network.matrix.should == [[1, 1, -1, -1], [-1, -1, 1, 1], [1, 1, -1, -1], [-1, -1, 1, 1], [1, 1, -1, -1], [-1, -1, 1, 1]]
		  end
		  it "should build a valud convergence matrix from all data" do
		  	training_data.each do |pair|
		  		@network.learn(pair[:input], pair[:output])
		  	end
		  	@network.matrix.should == [[5, -1, -3, -1], [-1, -3, 3, 1], [5, -1, -3, -1], [-3, -1, 1, 3], [1, 3, -3, -1], [-3, -1, 1, 3]]
		  end
		end

	end

	# AI::Memory::Associative::Bidirectional - An AI memory handler based on neural networks
# =head1 SYNOPSIS
#     print "Loading input sets... ";
#     foreach my $input (@$inputs){
#       $memory->learn($$input[0],$$input[1]);
#     }
#     print "done.\n";
#     print "Final weight matrix:\n".$memory->table('weights')."\n";
#     foreach my $test (@$tests){
#       if(my $steps = $memory->converge($$test[0],$$test[1])){
#         print "Stabilized to ".$memory->vector('X').', '.$memory->vector(Y).
#             " after ".($steps)." iteration".($steps==1?'':'s')."\n";
#       }
#     }
# =cut



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
