require 'test_helper'
include Project::Constants
include TestConstants::XML

describe '.process' do

  SLEEPING = Project::Constants::Activity::SLEEPING
  SUCCESS = Project::Constants::LastBuildStatus::SUCCESS
  BUILDING = Project::Constants::Activity::BUILDING
  FAILURE = Project::Constants::LastBuildStatus::FAILURE

  before(:each) do
    @input = double(PipelineWebResource)
    @parser = PipelineXMLParser.new
    @output = double(BuildMonitor)

    @ccPixel = BuildProcessor.new(@input, @parser, @output)
  end

  context 'when there are no projects' do

    let(:xml_document) {NO_PROJECTS}

    it 'should call success method' do
      allow(@input).to receive(:fetch).and_return(xml_document)

      expect(@output).to receive(:off)
      @ccPixel.run
    end
  end

  context 'when all builds are successful' do

    let(:xml_document) {build_xml([{:activity => SLEEPING, :last_build_status => SUCCESS},
                                  {:activity => SLEEPING, :last_build_status => SUCCESS}])}

    it 'should call success method' do
      allow(@input).to receive(:fetch).and_return(xml_document)

      expect(@output).to receive(:success)
      @ccPixel.run
    end

    context 'and project is building' do

      let(:xml_document) {build_xml([{:activity => SLEEPING, :last_build_status => SUCCESS},
                                    {:activity => BUILDING, :last_build_status => SUCCESS}])}

      it 'should call success_building' do
        allow(@input).to receive(:fetch).and_return(xml_document)

        expect(@output).to receive(:success_building)
        @ccPixel.run
      end

    end

  end

  context 'when all projects are failed' do

    let(:xml_document) {build_xml([{:activity => SLEEPING, :last_build_status => FAILURE},
                                  {:activity => SLEEPING, :last_build_status => FAILURE}])}

    it 'should call failure method' do
      allow(@input).to receive(:fetch).and_return(xml_document)

      expect(@output).to receive(:fail)
      @ccPixel.run
    end

    context 'and project is building' do

      let(:xml_document) {build_xml([{:activity => SLEEPING, :last_build_status => FAILURE},
                                    {:activity => BUILDING, :last_build_status => FAILURE}])}

      it 'should call failure_building' do
        allow(@input).to receive(:fetch).and_return(xml_document)

        expect(@output).to receive(:fail_building)
        @ccPixel.run
      end

    end

  end

  context 'when some tests have passed and some have failed' do

    let(:xml_document) {build_xml([{:activity => SLEEPING, :last_build_status => SUCCESS},
                                  {:activity => SLEEPING, :last_build_status => FAILURE}])}

    it 'should call failure method' do
      allow(@input).to receive(:fetch).and_return(xml_document)

      expect(@output).to receive(:fail)
      @ccPixel.run
    end

    context 'and a successful project is building' do

      let(:xml_document) {build_xml([{:activity => BUILDING, :last_build_status => SUCCESS},
                                    {:activity => SLEEPING, :last_build_status => FAILURE}])}

      it 'should call failure_building' do
        allow(@input).to receive(:fetch).and_return(xml_document)

        expect(@output).to receive(:fail_building)
        @ccPixel.run
      end

    end

    context 'and a failed project is building' do

      let(:xml_document) {build_xml([{:activity => SLEEPING, :last_build_status => SUCCESS},
                                    {:activity => BUILDING, :last_build_status => FAILURE}])}

      it 'should call failure_building' do
        allow(@input).to receive(:fetch).and_return(xml_document)

        expect(@output).to receive(:fail_building)
        @ccPixel.run
      end

    end

  end

end