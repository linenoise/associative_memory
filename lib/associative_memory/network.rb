require 'matrix'

module AssociativeMemory
  class Network

  	attr_accessor :matrix, :input, :output

  	def initialize(options)
  		@matrix = []
      @input = []
      @output = []
  	end

  	def empty?
  		self.matrix.length == 0
  	end

  	def valid?
      self.matrix && self.input && self.output
  	end

    def learn(input, output)
      input.each_with_index do |scalar, index|
        self.input[index] = 2 * scalar - 1
      end
      output.each_with_index do |scalar, index|
        self.output[index] = 2 * scalar - 1
      end
      input.each_with_index do |input_scalar, input_index|
        output.each_with_index do |output_scalar, output_index|
          self.matrix[input_index] ||= []
          self.matrix[input_index][output_index] ||= 0
          self.matrix[input_index][output_index] += self.input[input_index] * self.output[output_index]
        end
      end
    end

    def converge_input(input)
      output_vector = Matrix.row_vector(input) * Matrix.rows(self.matrix)
      return output_vector.row(0).to_a
    end

    def converge_and_threshold_input(input)
      threshold(converge_input(input))
    end

    def converge_output(output)
      input_vector = Matrix.row_vector(output) * Matrix.rows(self.matrix).transpose
      return input_vector.row(0).to_a
    end

    def converge_and_threshold_output(output)
      threshold(converge_output(output))
    end

    def threshold(vector)
      vector.map do |element|
        if element > 0 then 1 else 0 end
      end
    end

  end 
end
