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

  end 
end




# # $Id: Bidirectional.pm,v 0.1 2004/10/25 10:09:17 dann Exp $

# package AI::Memory::Associative::Bidirectional;

# =head1 NAME

# AI::Memory::Associative::Bidirectional - An AI memory handler based on neural networks

# =head1 SYNOPSIS

#     use AI::Memory::Associative::Bidirectional;

#     my $inputs = [
#       [ [1,0,1,0,1,0], [1,1,0,0] ],
#       [ [1,1,1,0,0,0], [1,0,1,0] ],
#     ];
#     my $tests = [
#       [ [1,0,1,0,1,0], [0,0,0,0] ],
#       [ [1,0,1,0,0,0], [1,1,0,0] ],
#     ];

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

# use strict;
# use warnings;
# require Exporter; 
# our @ISA = qw( Exporter );
# our $VERSION = (split(/ /,'$Id: Bidirectional.pm,v 0.1 2004/10/25 10:09:17 dann Exp $'))[2];


# ### new()
# #  constructor for the memory object.
# #  Takes nothing
# #  Returns an empty memory object
# ###
# sub new{
#   my $memory = {};
#   ($$memory{weights}, $$memory{X}, $$memory{Y}, $$memory{error}) = 
#     ([],[],[],'');
#   bless $memory, "AI::Memory::Associative::Bidirectional";
#   return $memory;
# }

# ### sub learn
# #  Inputs a set of vecors into the matrix, learning their patterns
# #  Takes the memory object, the input pattern, and the output pattern
# #  Returns nothing of value
# ###
# sub learn($$$){
#   my ($memory,$a,$b) = @_;
#   foreach my $i (0..scalar(int(@{$a}))-1){
#     $$memory{X}[$i] = 2 * $$a[$i] - 1;
#   }
#   foreach my $j (0..scalar(int(@{$b}))-1){
#     $$memory{Y}[$j] = 2 * $$b[$j] - 1;
#   }
#   foreach my $i (0..scalar(int(@{$a}))-1){
#     foreach my $j (0..scalar(int(@{$b}))-1){
#       $$memory{weights}[$i][$j] ||=0; # initialize when we need it
#       $$memory{weights}[$i][$j] = $$memory{weights}[$i][$j]
#         + $$memory{X}[$i] * $$memory{Y}[$j];
#     }
#   }
#   return 1;
# }

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

# ### table()
# # takes an array of vectors, formats it for printing
# # returns array of vectors in human-readable form
# ###
# sub table{
#   my ($memory, $key) = @_;
#   my $vectors = $$memory{$key};
#   my $str = '';
#   $str .= '   '.vector($_)."\n" foreach @$vectors;
#   $str;
# }
# 1;

# __END__

# =head1 SEE ALSO

# http://doulopolis.net/

# =head1 COPYRIGHT

# Copyright (c) 2004 Dann Stayskal E<lt>dann@stayskal.netE<gt>.

# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.

# =cut
