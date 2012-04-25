# Associative Memory

This is a ruby gem that lets you implement categorization systems with ease.

**Associative memory neural networks** make it easy to identify probable patterns between sets of named data points.  It can be cumbersome to interface with the neural network directly, however, as a typical convergence matrix has a fixed size and training period, which limits how useful they can be to a larger, integrated system.

`associative_memory` simplifies these kind of machine learning models by offering dynamically configurable input and output sets, and a convergence model that adapts to the inputs you give it each time.  This allows your code to concentrate on extrapolating meaningful patterns rather than juggling bitmasks and transposition matrices.

Under the hood, `associative_memory` implements a [hetero-associative recurrent neural network](https://en.wikipedia.org/wiki/Bidirectional_Associative_Memory) designed according to [Kosko's landmark paper](http://sipi.usc.edu/~kosko/BAM.pdf) establishing the model.  The model then dynamically rebuilds and adapts this network to accomodate new inputs as necessary.

## Synopsis

First, you'll want to tell `associative_memory` what you know about the set of things you're dealing with:

```ruby
animals = AssociativeMemory.new

@animals = AssociativeMemory.new
@animals.associate([:tail, :fur, :legs, :paws], [:cats, :rats])
@animals.associate([:fins, :swimming], 			[:fish])
@animals.associate([:tail, :shell], 			[:turtles])
@animals.associate([:arms, :legs], 				[:humans])
@animals.associate([:swimming], 				[:humans, :rats, :turtles])
@animals.associate([:running], 					[:humans, :rats, :cats])
```

Once you've done that, you can start asking it questions about patterns you've told it about:

```ruby
running_things = @animals.describe([:running])
[:cats, :rats, :humans].each do |thing|
	running_things.should include(thing)
end
@animals.describe([:humans]).should == [:arms, :legs, :running, :swimming]
@animals.describe([:swimming]).should == [:rats, :fish, :humans, :turtles]
@animals.describe([:tail]).should == [:cats, :rats, :fish, :turtles]
```

Furthermore, it will be able to extrapolate patterns from data not explicitly taught:

```ruby
@animals.describe([:fish]).should include(:tail)
```

If you have more patterns to input, you can do it at any time:

```ruby
animals.associate(:jumping).with(:humans, :rats, :cats)
animals.describe(:humans).should include(:jumping)
animals.describe(:turtles).should_not include(:jumping)
```

And it will be able to tell you that turtles don't jump.

### Debugging

Sometimes, you might want to know what in the sam hill is going on in that convergence network.  There's a method for that:

```ruby
@animals.associate([:tail, :fur, :legs, :paws], [:cats, :rats])
@animals.associate([:fins, :swimming], [:fish])
puts @animals.pretty_inspect
```

		associative_memory object: 29450400

		associated_pairs
		----------------
		[[:tail, :fur, :legs, :paws], [:cats, :rats]]
		[[:tail, :fins, :swimming], [:fish]]
		[[:tail, :shell], [:turtles]]
		[[:arms, :legs], [:humans]]
		[[:swimming], [:humans, :rats, :turtles]]
		[[:running], [:humans, :rats, :cats]]

		input_keyspace
		--------------
		[:arms, :fins, :fur, :legs, :paws, :running, :shell, :swimming, :tail]

		output_keyspace
		---------------
		[:cats, :rats, :fish, :humans, :turtles]

		convergence network
		-------------------
		[0, -2, 2, 2, 0]
		[0, -2, 6, -2, 0]
		[4, 2, 2, -2, 0]
		[2, 0, 0, 0, -2]
		[4, 2, 2, -2, 0]
		[4, 2, 2, 2, 0]
		[0, -2, 2, -2, 4]
		[-2, 0, 4, 0, 2]
		[0, -2, 2, -6, 0]


## Installation

When using RVM:

	$ gem install associative_memory

When using Bundler:

	# Add to your Gemfile
	gem "associative_memory"

	# Then install through Bundler
	$ bundle install

Otherwise:

	$ sudo gem install associative_memory

## TODO

* Implement auto-associative neural network model (v.0.3)
* Streamline network class with Matrix rather than Array

## Maintenance

If you would like to help maintain or improve this gem, I welcome your patches. The build environment of this gem is streamlined for [Test-driven development](https://en.wikipedia.org/wiki/Test-driven_development) using bundler, rvm, rspec, and guard.  To get it setup, you'll need to have [Ruby Version Manager (RVM)](http://beginrescueend.com/) installed, then do the following:

		$ git clone git@github.com:danndalf/associative_memory
		$ cd associative_memory
		  # ...and accept the .rvmrc
		  # have RVM build ruby 1.9 if necessary
		$ gem install bundler
		$ bundle install
		$ bundle exec guard start

Once guard starts, it will run through the full test suite.  After any changes are made to the libraries or specs, guard will re-run the relevant tests.  To re-run the full test suite, press enter at tie `> ` prompt in guard.  

After each test run, [simplecov](https://github.com/colszowka/simplecov) will generate a test coverage report in `coverage/index.html`.  This should show 100% coverage across all files when running the full test suite.

If you would like to patch this gem:

* Fork this repository
* Write your tests
* Make your changes
* Once all tests are passing and `simplecov` tells you all files are 100% covered,
	* Commit your changes
	* Send me a pull request
	* Wait for me to respond

This will help me integrate your patch as quickly and reliably as possible.

If you'd rather report a bug, please [open an issue on github](https://github.com/danndalf/associative_memory/issues).

## Resources

* Support: http://dann.stayskal.com/software/associative_memory

* Source code: http://github.com/danndalf/associative_memory

## License

This module is available under The MIT License.

Copyright (c) 2012 Dann Stayskal <dann@stayskal.com>.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
