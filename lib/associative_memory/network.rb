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

      # $a becomes input
      # $b becomes output
      # $memory{X} becomes self.input
      # $memory{Y} becomes self.output
      # $aPrev becomes previous_input
      # $aPrev becomes previous_output

    def converge(input, output)
      previous_input = []
      previous_output = []
      ### If either vector changed on the last iteration, keep calculating
      while (input != previous_input) || (output != previous_output) do
        previous_input = input
        previous_output = output

        ### Step 6: Calculate new A->B iteration
        output.each_with_index do |output_scalar, output_index|
          weight = 0
          input.each_with_index do |input_scalar, input_index|
            weight += output_scalar * self.matrix[input_index][output_index]
          end
          if weight > 0
            output[output_index] = 1
          elsif weight < 0
            output[output_index] = 0
          end
        end

        # foreach my $j (0..scalar(int(@{$b}))-1){
        #   my $sum = 0;
        #   foreach my $i (0..scalar(int(@{$a}))-1){
        #     $sum += $$b[$i] * $$memory{weights}[$i][$j];
        #   }
        #   if($sum > 0){
        #     $$b[$j] = 1;
        #   }elsif($sum < 0){
        #     $$b[$j] = 0;
        #   }
        # }

        ### Step 7: Calculate new B->A iteration
        input.each_with_index do |input_scalar, input_index|
          weight = 0
          output.each_with_index do |output_scalar, output_index|
            weight += input_scalar * self.matrix[input_index][output_index]
          end
          if weight > 0
            input[input_index] = 1
          elsif weight < 0
            input[input_index] = 0
          end
        end

        # foreach my $i (0..scalar(int(@{$a}))-1){
        #   my $sum = 0;
        #   foreach my $j (0..scalar(int(@{$b}))-1){
        #     $sum += $$a[$i] * $$memory{weights}[$i][$j];
        #   }
        #   if($sum > 0){
        #      $$a[$i] = 1;
        #   }elsif($sum < 0){
        #      $$a[$i] = 0;
        #   }
        # }

        puts " input: #{input}   output: #{output}"
      end
      self.input = input
      self.output = output
      return true
    end

  end 
end
