module Quickeebooks
  module Common
    class IntuitRequestException < Exception
      attr_reader :code, :cause
      def initialize(msg, code=0, cause="")
        @code  = code.to_i
        @cause = cause
        super(msg)
      end
    end

    class AuthorizationFailure < Exception; end
  end
end