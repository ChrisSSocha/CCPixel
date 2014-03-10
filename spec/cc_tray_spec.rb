require 'test_helper'
include Constants

describe '.getProjects' do

  let(:ccFetcher) {double(CCFetch)}

  context 'when there are no projects' do

    before(:each) do
      allow(ccFetcher).to receive(:fetch).and_return(XML::NoProjects)
      @ccTray = CCTray.new(ccFetcher)
    end

    it 'should return empty array' do
      expect(@ccTray.getProjects()).to be_empty
    end

  end

  context 'when there is one project' do

    before(:each) do
      allow(ccFetcher).to receive(:fetch).and_return(XML::OneProject)
      @ccTray = CCTray.new(ccFetcher)
    end

    it 'should return single project' do
      expect(@ccTray.getProjects.length).to eq(1)
      expect(@ccTray.getProjects[0]).to eq(Constants::Project::SampleProject1)
    end

  end

  context 'when there are multiple project' do

    before(:each) do
      allow(ccFetcher).to receive(:fetch).and_return(XML::MultipleProjects)
      @ccTray = CCTray.new(ccFetcher)
    end

    it 'should return single project' do
      expect(@ccTray.getProjects.length).to eq(2)
      expect(@ccTray.getProjects[0]).to eq(Constants::Project::SampleProject1)
      expect(@ccTray.getProjects[1]).to eq(Constants::Project::SampleProject2)
    end

  end

end