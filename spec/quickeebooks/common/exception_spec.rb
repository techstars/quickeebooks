describe Quickeebooks::Common::IntuitRequestException, focus:true do
  describe '#from_parsed_xml' do
    subject { described_class.from_parsed_xml(parsed_xml) }

    context "From Base Exception Model XML" do
      let(:parsed_xml) { Nokogiri::XML(sharedFixture("internal_server_error.xml")) }

      its(:code) { should eq 500 }
      its(:message) { should eq "Internal Server Error" }
      its(:cause) { should eq "SERVER" }
    end

    context "From Status report HTML" do
      let(:parsed_xml) { Nokogiri::XML(sharedFixture("status_report_no_destination_found.html")) }

      its(:code) { should eq 400 }
      its(:message) { should eq "No destination found for given partition key" }
      its(:cause) { should eq "The request sent by the client was syntactically incorrect (message=No destination found for given partition key; errorCode=007001; statusCode=400)." }
    end
  end
end