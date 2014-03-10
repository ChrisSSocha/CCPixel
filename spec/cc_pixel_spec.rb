require 'test_helper'
include TestConstants::Project

describe '.process' do

  before(:each) do
    @ccOutput = double(CCOutput)
    @ccPixel = CCPixel.new(@ccOutput)
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

end