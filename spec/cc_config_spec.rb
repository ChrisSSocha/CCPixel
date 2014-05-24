require 'test_helper'

describe 'Config' do

  context 'config file does not exist' do

    it 'should throw error' do
      expect {Configuration.load_yaml(StringIO.new())}.to raise_error(InvalidConfigFormat)
    end

  end

  context 'config file exists' do

    describe 'when getting sleep' do

      it 'should throw error when sleep not correct format' do
        file = StringIO.new(TestConstants::YAML::InvalidSleepYAML.to_yaml)
        expect{Configuration.load_yaml(file)}.to raise_error(InvalidConfigFormat)
      end

      it 'should return sleep' do
        file = StringIO.new(TestConstants::YAML::ValidYAML.to_yaml)
        config = Configuration.load_yaml(file)

        expect(config.getSleepTime()).to eq(TestConstants::YAML::ValidSleep)
      end

    end

    it 'should return url' do
      file = StringIO.new(TestConstants::YAML::ValidYAML.to_yaml)
      config = Configuration.load_yaml(file)

      expect(config.getUrl()).to eq(TestConstants::YAML::ValidUrl)
    end

    it 'should return useAuth' do
      file = StringIO.new(TestConstants::YAML::ValidYAML.to_yaml)

      config = Configuration.load_yaml(file)

      expect(config.getSleepTime()).to eq(TestConstants::YAML::ValidSleep)
    end

    it 'should return username' do
      file = StringIO.new(TestConstants::YAML::ValidYAML.to_yaml)
      config = Configuration.load_yaml(file)

      expect(config.getSleepTime()).to eq(TestConstants::YAML::ValidSleep)
    end

    it 'should return password' do
      file = StringIO.new(TestConstants::YAML::ValidYAML.to_yaml)
      config = Configuration.load_yaml(file)

      expect(config.getSleepTime()).to eq(TestConstants::YAML::ValidSleep)
    end

  end

end