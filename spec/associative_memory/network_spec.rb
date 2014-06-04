require 'spec_helper'

describe AssociativeMemory::Network do
	let(:training_data) {[
		{:input => [1, 0, 1, 0, 1, 0], :output => [1, 1, 0, 0], :converged_output => [5, 7, -5, -7], :converged_input => [4, -4, 4, -4, 4, -4] },
		{:input => [1, 1, 1, 0, 0, 0], :output => [0, 1, 1, 0], :converged_output => [-1, 5, 1, -5], :converged_input => [2, 2, 2, -2, -2, -2] },
		{:input => [0, 1, 0, 1, 0, 1], :output => [0, 0, 1, 1], :converged_output => [-5, -7, 5, 7], :converged_input => [-4, 4, -4, 4, -4, 4] }
	]}
	describe "a new associative memory network" do
		before do
			@network = AssociativeMemory::Network.new
		end
		it "is a kind of associative memory network" do
			expect(@network).to be_a_kind_of(AssociativeMemory::Network)
		end
		it "is empty" do
			expect(@network.empty?).to be true
		end
		it "is not valid until it learns a pattern" do
			expect(@network.valid?).to be false
		end
		it "valid once it learns a pattern" do
			@network.learn(training_data[0][:input], training_data[0][:output])
			expect(@network.valid?).to be true
		end
	end

	describe "training a network" do
		before do
			@network = AssociativeMemory::Network.new
		end
		it "builds a valid convergence matrix from a single data point" do
			@network.learn(training_data[0][:input], training_data[0][:output])
			expect(@network.matrix).to eq([[1, 1, -1, -1], [-1, -1, 1, 1], [1, 1, -1, -1], [-1, -1, 1, 1], [1, 1, -1, -1], [-1, -1, 1, 1]])
		end
		it "builds a valid convergence matrix from all data" do
			training_data.each do |pair|
				@network.learn(pair[:input], pair[:output])
			end
			expect(@network.matrix).to eq([[1, 3, -1, -3], [-3, -1, 3, 1], [1, 3, -1, -3], [-1, -3, 1, 3], [3, 1, -3, -1], [-1, -3, 1, 3]])
		end
	end

	describe "converging a network" do
		before do
			@network = AssociativeMemory::Network.new
			training_data.each do |pair|
				@network.learn(pair[:input], pair[:output])
			end
		end
		it "rebuilds all available output data from learned input data" do
			training_data.each do |pair|
				expect(@network.converge_input(pair[:input])).to eq(pair[:converged_output])
				expect(@network.converge_and_bitmask_input(pair[:input])).to eq(pair[:output])
			end
		end
		it "rebuilds all available input data from learned output data" do
			training_data.each do |pair|
				expect(@network.converge_output(pair[:output])).to eq(pair[:converged_input])
				expect(@network.converge_and_bitmask_output(pair[:output])).to eq(pair[:input])
			end
		end
	end
end
