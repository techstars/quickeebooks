module Quickeebooks
  module Common
    class IntuitRequestException < Exception
      attr_accessor :code, :cause
      def initialize(msg)
        super(msg)
      end
    end

    class AuthorizationFailure < Exception; end
  end
end