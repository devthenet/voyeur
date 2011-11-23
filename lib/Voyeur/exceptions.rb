module Voyeur
  module Exceptions
    class NoVideoPresent < StandardError; end
    class InvalidFormat < StandardError; end
    class InvalidLocation < StandardError; end
  end
end
