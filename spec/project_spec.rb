require 'test_helper'
include TestConstants::Project

describe 'Builder' do

  context 'build basic project' do

    let(:project) {Project::Builder.new(NAME_1, ACTIVITY).build}

    it 'should get name' do
      expect(project.name).to eq(NAME_1)
    end

    it 'should get activity' do
      expect(project.activity).to eq(ACTIVITY)
    end

    it 'all other attributes should be nil' do
      expect(project.last_build_status).to be_nil
      expect(project.last_build_label).to be_nil
      expect(project.last_build_time).to be_nil
      expect(project.next_build_time).to be_nil
      expect(project.web_url).to be_nil
    end

  end

  context 'build complete project' do

    let(:project) {Project::Builder.new(NAME_1, ACTIVITY)
                                   .last_build_status(LAST_BUILD_STATUS)
                                   .last_build_label(LAST_BUILD_LABEL)
                                   .last_build_time(LAST_BUILD_TIME)
                                   .next_build_time(NEXT_BUILD_TIME)
                                   .web_url(WEB_URL).build()}

    it 'should get name' do
      expect(project.name).to eq(NAME_1)
    end

    it 'should get activity' do
      expect(project.activity).to eq(ACTIVITY)
    end

    it 'should get lastBuildStatus' do
      expect(project.last_build_status).to eq(LAST_BUILD_STATUS)
    end

    it 'should get lastBuildLabel' do
      expect(project.last_build_label).to eq(LAST_BUILD_LABEL)
    end

    it 'should get lastBuildTime' do
      expect(project.last_build_time).to eq(LAST_BUILD_TIME)
    end

    it 'should get nextBuildTime' do
      expect(project.next_build_time).to eq(NEXT_BUILD_TIME)
    end

    it 'should get webUrl' do
      expect(project.web_url).to eq(WEB_URL)
    end

  end

end