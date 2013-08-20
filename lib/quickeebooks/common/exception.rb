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

        error = if !xml.namespaces.empty?
          parse_base_exception_model(xml)
        else
          parse_status_report_html(xml)
        end

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

      def self.parse_status_report_html(xml)
        value_hash, description = xml.css("u").collect{|t| t.text }

        values = value_hash.split("; ").inject({}) do |memo, pair|
          key, value = pair.split("=")
          memo[key.to_sym] = value
          memo
        end

        {
          :message => values[:message],
          :code => values[:statusCode],
          :cause => description
        }
      end
    end

    class AuthorizationFailure < Exception; end
  end
end