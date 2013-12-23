module Gitlab
  # Converts hashes to the objects.
  class ObjectifiedHash
    # Creates a new ObjectifiedHash.
    def initialize(hash)
      @data = hash.inject({}) do |data, (key,value)|
        value = ObjectifiedHash.new(value) if value.is_a? Hash
        data[key.to_s] = value
        data
      end
    end

    # Delegate to ObjectifiedHash
    def method_missing(*args)
      return @data[args.first.to_s] if @data.key?(args.first.to_s)
      @data.__send__(*args)
    end
  end
end
