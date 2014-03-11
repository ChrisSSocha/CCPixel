require 'test_helper'
include TestConstants::Project

describe '.process' do

  before(:each) do
    @ccOutput = double(CCOutput)
    @ccPixel = CCPixel.new(@ccOutput)
  end

  context 'when there are no projects' do
    let(:projects) {[]}

    it 'should call success method' do
      expect(@ccOutput).to receive(:off)
      @ccPixel.process(projects)
    end
  end

  context 'when all builds are successful' do

    let(:projects) {[SuccessfulProject, SuccessfulProject]}

    it 'should call success method' do
      expect(@ccOutput).to receive(:success)
      @ccPixel.process(projects)
    end

    context 'and project is building' do

      let(:projects) {[SuccessfulProject, SuccessfulProjectBuilding]}

      it 'should call success_building' do
        expect(@ccOutput).to receive(:success_building)
        @ccPixel.process(projects)
      end

    end

  end

  context 'when all projects are failed' do

    let(:projects) {[FailedProject, FailedProject]}

    it 'should call failure method' do
      expect(@ccOutput).to receive(:fail)
      @ccPixel.process(projects)
    end

    context 'and project is building' do

      let(:projects) {[FailedProject, FailedProjectBuilding]}

      it 'should call failure_building' do
        expect(@ccOutput).to receive(:fail_building)
        @ccPixel.process(projects)
      end

    end

  end

  context 'when some tests have passed and some have failed' do

    let(:projects) {[SuccessfulProject, FailedProject]}

    it 'should call failure method' do
      expect(@ccOutput).to receive(:fail)
      @ccPixel.process(projects)
    end

    context 'and a successful project is building' do

      let(:projects) {[SuccessfulProjectBuilding, FailedProject]}

      it 'should call failure_building' do
        expect(@ccOutput).to receive(:fail_building)
        @ccPixel.process(projects)
      end

    end

    context 'and a failed project is building' do

      let(:projects) {[SuccessfulProject, FailedProjectBuilding]}

      it 'should call failure_building' do
        expect(@ccOutput).to receive(:fail_building)
        @ccPixel.process(projects)
      end

    end

  end

end