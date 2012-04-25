Associative Memory
==================

`associative_memory` lets you implement categorization systems with ease.

Associative memory neural networks make it easy to identify probable patterns between sets of named data points.  It can be cumbersome to interface with the neural network directly, however, as a typical convergence matrix has a fixed size and training period, which limits how useful they can be to a larger, integrated system.

`associative_memory` simplifies these kind of machine learning models by offering dynamically configurable input and output sets, and a convergence model that adapts to the inputs you give it each time.  This allows your code to concentrate on extrapolating meaningful patterns rather than juggling bitmasks and transposition matrices.

Under the hood, `associative_memory` implements a [hetero-associative recurrent neural network](https://en.wikipedia.org/wiki/Bidirectional_Associative_Memory) designed according to [Kosko's landmark paper](http://sipi.usc.edu/~kosko/BAM.pdf) establishing the model.  The model then dynamically rebuilds and adapts this network to accomodate new inputs as necessary.

Synopsis
--------

First, you'll want to tell `associative_memory` what you know about the set of things you're dealing with:

```ruby
animals = AssociativeMemory.new

animals.associate(:tail, :fur, :paws).with(:cats, :dogs)
animals.associate(:tail, :fins, :swimming).with(:fish)
animals.associate(:tail, :shell).with(:turtles)
animals.associate(:arms, :legs).with(:humans)
animals.associate(:swimming).with(:humans, :fish, :dogs, :turtles)
animals.associate(:running).with(:humans, :dogs, :cats)
```

Once you've done that, you can start asking it questions about patterns:

```ruby
animals.describe(:humans)
...

animals.describe(:swimming)
...

animals.describe(:running)
...
```

If you have more patterns to input, you can do it at any time:

```ruby
animals.associate(:jumping).with(:humans, :dogs, :cats)
animals.describe(:humans)
...
animals.describe(:turtles)
...
```

Turtles don't jump.

Installation
------------

When using RVM:

	$ gem install associative_memory

When using Bundler:

	# Add to your Gemfile
	gem "associative_memory"

	# Then install through Bundler
	$ bundle install

Otherwise:

	$ sudo gem install associative_memory

Resources
---------

* Support: http://dann.stayskal.com/software/associative_memory

* Source code: http://github.com/danndalf/associative_memory

License
--------

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
