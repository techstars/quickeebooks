module Quickeebooks
  module Common
    class IntuitRequestException < Exception
      attr_reader :code, :cause
      def initialize(msg, code=0, cause="")
        @code  = code.to_i
        @cause = cause
        super(msg)
      end

      def self.from_parsed_xml(xml)
        error = parse_base_exception_model(xml)

        new(error[:message], error[:code], error[:cause])
      end

    private
      def self.parse_base_exception_model(xml)
        error = {:message => "", :code => 0, :cause => ""}

        fault = xml.xpath("//xmlns:FaultInfo/xmlns:Message")[0]
        if fault
          error[:message] = fault.text
        end
        error_code = xml.xpath("//xmlns:FaultInfo/xmlns:ErrorCode")[0]
        if error_code
          error[:code] = error_code.text
        end
        error_cause = xml.xpath("//xmlns:FaultInfo/xmlns:Cause")[0]
        if error_cause
          error[:cause] = error_cause.text
        end

        error
      end

    end

    class AuthorizationFailure < Exception; end
  end
end