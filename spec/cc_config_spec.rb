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
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::InvalidUrlYAML)
        config = CCConfig.new(valid_file)

        expect{config.getUrl()}.to raise_error(InvalidUrlError)
      end

      it 'should throw error if URL does not exist' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::NoUrlYAML)
        config = CCConfig.new(valid_file)

        expect{config.getUrl()}.to raise_error(ResourceNotFoundError)
      end

      it 'should return url' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::ValidYAMLNoAuth)
        config = CCConfig.new(valid_file)

        expect(config.getUrl()).to eq(TestConstants::YAML::ValidUrl)
      end

    end

    describe 'when getting sleep' do

      it 'should throw error when sleep not correct format' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::InvalidSleepYAML)
        config = CCConfig.new(valid_file)

        expect{config.getSleepTime()}.to raise_error(TypeError)
      end

      it 'should throw error if sleep does not exist' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::NoSleepYAML)
        config = CCConfig.new(valid_file)

        expect{config.getSleepTime()}.to raise_error(ResourceNotFoundError)
      end

      it 'should return sleep' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::ValidYAMLNoAuth)
        config = CCConfig.new(valid_file)

        expect(config.getSleepTime()).to eq(TestConstants::YAML::ValidSleep)
      end

    end

    describe 'when getting auth' do

      it 'should throw error if no auth' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::ValidYAMLNoAuth)
        config = CCConfig.new(valid_file)

        expect{config.getAuth()}.to raise_error(InvalidAuthFormatError)
      end

      it 'should throw error if no username' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::NoUsernameYAML)
        config = CCConfig.new(valid_file)

        expect{config.getAuth()}.to raise_error(ResourceNotFoundError)
      end

      it 'should throw error if no password' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::NoPasswordYAML)
        config = CCConfig.new(valid_file)

        expect{config.getAuth()}.to raise_error(ResourceNotFoundError)
      end

      it 'should return auth hash' do
        allow_any_instance_of(CCConfig).to receive(:load).and_return(TestConstants::YAML::ValidYAMLWithAuth)
        config = CCConfig.new(valid_file)

        expect(config.getAuth()).to eq(TestConstants::YAML::AuthHash)
      end

    end

  end

end