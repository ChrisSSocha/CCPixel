require 'test_helper'
include TestConstants::Project

describe 'Builder' do

  context 'build basic project' do

    let(:project) {Project::Builder.new(Name, Activity).build()}

    it 'should get name' do
      expect(project.name).to eq(Name)
    end

    it 'should get activity' do
      expect(project.activity).to eq(Activity)
    end

    it 'all other attributes should be nil' do
      expect(project.lastBuildStatus).to be_nil
      expect(project.lastBuildLabel).to be_nil
      expect(project.lastBuildTime).to be_nil
      expect(project.nextBuildTime).to be_nil
      expect(project.webUrl).to be_nil
    end

  end

  context 'build complete project' do

    let(:project) {Project::Builder.new(Name, Activity)
                                   .lastBuildStatus(LastBuildStatus)
                                   .lastBuildLabel(LastBuildLabel)
                                   .lastBuildTime(LastBuildTime)
                                   .nextBuildTime(NextBuildTime)
                                   .webUrl(WebURL).build()}

    it 'should get name' do
      expect(project.name).to eq(Name)
    end

    it 'should get activity' do
      expect(project.activity).to eq(Activity)
    end

    it 'should get lastBuildStatus' do
      expect(project.lastBuildStatus).to eq(LastBuildStatus)
    end

    it 'should get lastBuildLabel' do
      expect(project.lastBuildLabel).to eq(LastBuildLabel)
    end

    it 'should get lastBuildTime' do
      expect(project.lastBuildTime).to eq(LastBuildTime)
    end

    it 'should get nextBuildTime' do
      expect(project.nextBuildTime).to eq(NextBuildTime)
    end

    it 'should get webUrl' do
      expect(project.webUrl).to eq(WebURL)
    end

  end

end