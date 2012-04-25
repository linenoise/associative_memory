require 'associative_memory/network'

module AssociativeMemory

	VERSION = '0.2.0'
	class << self

		attr_accessor :associated_pairs, :network, :input_keyspace, :output_keyspace

		def new(options={})
			self.associated_pairs = []
			self.input_keyspace = []
			self.output_keyspace = []
			return self
		end

		def associate(inputs=[], outputs=[])
			existing_input_keyspace_length = self.input_keyspace.length
			existing_output_keyspace_length = self.output_keyspace.length

			# Determine updated keyspace mapping
			self.associated_pairs.push([inputs, outputs])
			self.input_keyspace = self.associated_pairs.map{|pair| pair[0]}.flatten.uniq.sort
			self.output_keyspace = self.associated_pairs.map{|pair| pair[1]}.flatten.uniq.sort
			@input_bitmask = self.input_keyspace.map{|element| if inputs.include?(element) then 1 else 0 end }
			@output_bitmask = self.output_keyspace.map{|element| if outputs.include?(element) then 1 else 0 end }

			# If this new association changes the cardinality of our input or
			# output pattern space, refresh structure of the network
			if self.input_keyspace.length != existing_input_keyspace_length || self.output_keyspace.length != existing_output_keyspace_length
				self.network = AssociativeMemory::Network.new
				self.associated_pairs.each{|pair|
					pairwise_input_bitmask = self.input_keyspace.map{|element| if pair[0].include?(element) then 1 else 0 end }
					pairwise_output_bitmask = self.output_keyspace.map{|element| if pair[1].include?(element) then 1 else 0 end }
					self.network.learn(pairwise_input_bitmask,pairwise_output_bitmask)
				}
			else
				self.network.learn(@input_bitmask, @output_bitmask)
			end
		end

		def describe(vector)
			description = []

			# Search forward through the input keyspace
			input_bitmask = self.input_keyspace.map{|input_key| if vector.include?(input_key) then 1 else 0 end }
			if input_bitmask.include?(1)
				convergence_bitmask = self.network.converge_and_bitmask_input(input_bitmask)
				self.output_keyspace.each_with_index do |output_key, index|
					if convergence_bitmask[index] == 1
						description.push(output_key)
					end
				end
			end

			# Search backwards through the output keyspace
			output_bitmask = self.output_keyspace.map{|output_key| if vector.include?(output_key) then 1 else 0 end }
			if output_bitmask.include?(1)
				convergence_bitmask = self.network.converge_and_bitmask_output(output_bitmask)
				convergence_vector = self.network.converge_output(output_bitmask)
				self.input_keyspace.each_with_index do |input_key, index|
					if convergence_bitmask[index] == 1
						description.push(input_key)
					end
				end
			end

			return description.sort.uniq
		end

		def valid?
			return self.associated_pairs.length > 0 &&self.input_keyspace.length > 0 &&self.output_keyspace.length > 0 && self.network.valid?
		end

		def pretty_inspect
			"associative_memory object: #{self.object_id}\n\n" +
			"associated_pairs\n" + 
			"----------------\n" + 
			self.associated_pairs.map{|a| a.inspect}.join("\n") + "\n\n" +
			"input_keyspace\n" + 
			"--------------\n" + 
			self.input_keyspace.inspect + "\n\n" +
			"output_keyspace\n" + 
			"---------------\n" + 
			self.output_keyspace.inspect + "\n\n" +
			"convergence network\n" +
			"-------------------\n" +
			self.network.matrix.map{|a| a.inspect}.join("\n") + "\n\n"
		end
	end
end