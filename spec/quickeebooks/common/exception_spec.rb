describe Quickeebooks::Common::IntuitRequestException do
  describe '#from_parsed_xml' do
    subject { described_class.from_parsed_xml(parsed_xml) }

    context "From Base Exception Model XML" do
      let(:parsed_xml) { Nokogiri::XML(sharedFixture("internal_server_error.xml")) }

      its(:code) { should eq 500 }
      its(:message) { should eq "Internal Server Error" }
      its(:cause) { should eq "SERVER" }
    end
  end
end

describe Quickeebooks::Common::StatusReportException do
  describe '#from_parsed_xml' do
    subject { described_class.from_parsed_xml(parsed_xml) }

    context "From 400 Status No Destination Found HTML" do
      let(:parsed_xml) { Nokogiri::XML(sharedFixture("status_report_no_destination_found.html")) }

      its(:code) { should eq 400 }
      its(:status_code) { should eq 400 }
      its(:error_code) { should eq "007001" }
      its(:message) { should eq "No destination found for given partition key" }
      its(:cause) { should eq "The request sent by the client was syntactically incorrect (message=No destination found for given partition key; errorCode=007001; statusCode=400)." }
    end

    context "From 500 Status Parse Error HTML" do
      let(:parsed_xml) { Nokogiri::XML(sharedFixture("status_report_parse_error.html")) }

      its(:code) { should eq 500 }
      its(:status_code) { should eq 500 }
      its(:error_code) { should eq "006003" }
      its(:message) { should eq "General IO error while proxying request" }
      its(:cause) { should eq "The server encountered an internal error (message=General IO error while proxying request; errorCode=006003; statusCode=500) that prevented it from fulfilling this request." }
    end
  end
end