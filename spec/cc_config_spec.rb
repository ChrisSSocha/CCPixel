require 'test_helper'

describe 'Config' do

  context 'config file does not exist' do

    let(:invalid_file) {"does_not_exist.yml"}

    it 'should throw error' do
      expect {CCConfig.new(invalid_file)}.to raise_error(NoFileError)
    end

  end

  context 'config file exists' do

    let(:valid_file) {"exists.yml"}

    describe 'when getting URL' do

      it 'should throw error when URL not correct format' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::InvalidUrl)
        config = CCConfig.new(valid_file)

        expect{config.getUrl()}.to raise_error(InvalidUrlError)
      end

      it 'should throw error if URL does not exist' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::NoUrl)
        config = CCConfig.new(valid_file)

        expect{config.getUrl()}.to raise_error(ResourceNotFoundError)
      end

    end

    describe 'when getting sleep' do

      it 'should throw error when sleep not correct format' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::InvalidSleep)
        config = CCConfig.new(valid_file)

        expect{config.getSleepTime()}.to raise_error(TypeError)
      end

      it 'should throw error if sleep does not exist' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::NoSleep)
        config = CCConfig.new(valid_file)

        expect{config.getSleepTime()}.to raise_error(ResourceNotFoundError)
      end

    end

  end

end