require 'matrix'

module AssociativeMemory
	class Network

		attr_accessor :matrix

		def initialize(options={})
			@matrix = []
		end

		def empty?
			self.matrix.length == 0
		end

		def valid?
			self.matrix.length > 0
		end
		
		def learn(input, output)
			input_buffer = []
			output_buffer = []
			input.each_with_index do |scalar, index|
				input_buffer[index] = 2 * scalar - 1
			end
			output.each_with_index do |scalar, index|
				output_buffer[index] = 2 * scalar - 1
			end
			input.each_with_index do |input_scalar, input_index|
				output.each_with_index do |output_scalar, output_index|
					self.matrix[input_index] ||= []
					self.matrix[input_index][output_index] ||= 0
					self.matrix[input_index][output_index] += input_buffer[input_index] * output_buffer[output_index]
				end
			end
		end

		def converge_input(input)
			output_vector = Matrix.row_vector(input) * Matrix.rows(self.matrix)
			return output_vector.row(0).to_a
		end

		def converge_and_bitmask_input(input)
			bitmask(converge_input(input))
		end

		def converge_output(output)
			input_vector = Matrix.row_vector(output) * Matrix.rows(self.matrix).transpose
			return input_vector.row(0).to_a
		end

		def converge_and_bitmask_output(output)
			bitmask(converge_output(output))
		end

		def bitmask(vector)
			vector.map do |element|
				if element < 0 then 0 else 1 end
			end
		end
	end
end
