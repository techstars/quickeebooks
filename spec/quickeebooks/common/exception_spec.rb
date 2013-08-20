describe Quickeebooks::Common::IntuitRequestException, focus:true do
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