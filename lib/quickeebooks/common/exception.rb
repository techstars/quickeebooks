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

        new(error[:message], error[:code], error[:cause])
      end
    end

    class StatusReportException < Exception
      attr_reader :error_code, :status_code, :cause

      def initialize(msg, error_code=0, status_code=0, cause="")
        @error_code  = error_code
        @status_code = status_code.to_i
        @cause = cause

        super(msg)
      end
      alias :code :status_code

      def self.from_parsed_xml(xml)
        value_hash, description = xml.css("u").collect{|t| t.text }

        values = value_hash.split("; ").inject({}) do |memo, pair|
          key, value = pair.split("=")
          memo[key.to_sym] = value
          memo
        end

        new(values[:message], values[:errorCode], values[:statusCode], description)
      end
    end

    class AuthorizationFailure < Exception; end
  end
end