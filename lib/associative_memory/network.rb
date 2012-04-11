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
      input.each_with_index do |scalar, input_index|
        output.each_with_index do |scalar, output_index|
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

  end 
end


# ### converge()
# # runs iterations on the network until it converges to a stable value
# # takes:
# #   $memory - the memory object
# #   $a - the input pattern
# #   $b - the output pattern
# # returns:
# #   1 or greater - steps required to converge 
# #   0 - failure ( read $$memory{error} for details )
# ###
# sub converge($$$){
#   my ($memory, $a, $b) = @_;
#   my $aPrev = [];
#   my $bPrev = [];
#   my $step;
#   ### If either vector changed on the last iteration, keep calculating
#   for($step = 0; _changed($a,$aPrev)||_changed($b,$bPrev); $step++){
#     $$aPrev[$_] = $$a[$_] foreach (0..int(@{$a})-1);
#     $$bPrev[$_] = $$b[$_] foreach (0..int(@{$b})-1);
#     ### Step 6: Calculate new A->B iteration
#     foreach my $j (0..scalar(int(@{$b}))-1){
#       my $sum = 0;
#       foreach my $i (0..scalar(int(@{$a}))-1){
#         $sum += $$a[$i] * $$memory{weights}[$i][$j];
#       }
#       if($sum > 0){
#         $$b[$j] = 1;
#       }elsif($sum < 0){
#         $$b[$j] = 0;
#       }
#     }
#     ### Step 7: Calculate new B->A iteration
#     foreach my $i (0..scalar(int(@{$a}))-1){
#       my $sum = 0;
#       foreach my $j (0..scalar(int(@{$b}))-1){
#         $sum += $$a[$i] * $$memory{weights}[$i][$j];
#       }
#       if($sum > 0){
#          $$a[$i] = 1;
#       }elsif($sum < 0){
#          $$a[$i] = 0;
#       }
#     }
#   }
#   $$memory{X} = $a;
#   $$memory{Y} = $b;
#   return $step;
# }

# ### _changed()
# # takes two vectors, returns 1 if they're different, 0 if identical
# ###
# sub _changed{
#   my @vectors = @_;
#   return 1 if !exists($vectors[0][0]) || !exists($vectors[1][0]);
#   foreach(0..int(@{$vectors[1]})-1){
#     return 1 if $vectors[0][$_] != $vectors[1][$_];
#   }
#   return 0;
# }

# ### vector()
# # takes a vector, formats it for printing
# # returns vector in human-readable form
# ###
# sub vector{
#   my ($memory,$key) = @_;
#   my $vector = $$memory{$key};
#   return "no vector at $key!" unless $vector;
#   return '['.join(',',map({sprintf('%2d',$_)}@{$vector})).']';
# }
