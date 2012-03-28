require 'associative_memory/network'

module AssociativeMemory
  VERSION = '0.0.1'

  class << self
    # Alias for AssociativeMemory::Network.new
    #   
    # @return [AssociativeMemory::Network]
    def new(options={})
      AssociativeMemory::Network.new(options)
    end 

    # Delegate to AssociativeMemory::Network
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end 

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end 
  end 
end