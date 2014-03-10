require 'test_helper'
include TestConstants

describe '.getProjects' do

  let(:ccInput) {double(CCInput)}

  context 'when there are no projects' do

    before(:each) do
      allow(ccInput).to receive(:fetch).and_return(XML::NoProjects)
      @ccParser = CCParser.new(ccInput)
    end

    it 'should return empty array' do
      expect(@ccParser.getProjects()).to be_empty
    end

  end

  context 'when there is one project' do

    before(:each) do
      allow(ccInput).to receive(:fetch).and_return(XML::OneProject)
      @ccParser = CCParser.new(ccInput)
    end

    it 'should return single project' do
      expect(@ccParser.getProjects.length).to eq(1)
      expect(@ccParser.getProjects[0]).to eq(TestConstants::Project::SampleProject1)
    end

  end

  context 'when there are multiple project' do

    before(:each) do
      allow(ccInput).to receive(:fetch).and_return(XML::MultipleProjects)
      @ccParser = CCParser.new(ccInput)
    end

    it 'should return single project' do
      expect(@ccParser.getProjects.length).to eq(2)
      expect(@ccParser.getProjects[0]).to eq(TestConstants::Project::SampleProject1)
      expect(@ccParser.getProjects[1]).to eq(TestConstants::Project::SampleProject2)
    end

  end

end