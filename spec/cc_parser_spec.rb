require 'test_helper'
include TestConstants

describe '.getProjects' do

  let(:ccParser) {PipelineXMLParser.new}

  context 'when there are no projects' do

    it 'should return empty array' do
      expect(ccParser.get_projects(XML::NO_PROJECTS)).to be_empty
    end

  end

  context 'when there is one project' do

    it 'should return single project' do
      projects = ccParser.get_projects(XML::ONE_PROJECT)
      expect(projects.length).to eq(1)
      expect(projects[0]).to eq(Project::SAMPLE_PROJECT_1)
    end

  end

  context 'when there are multiple project' do

    it 'should return single project' do
      projects = ccParser.get_projects(XML::MULTIPLE_PROJECTS)
      expect(projects.length).to eq(2)
      expect(projects[0]).to eq(Project::SAMPLE_PROJECT_1)
      expect(projects[1]).to eq(Project::SAMPLE_PROJECT_2)
    end

  end

end