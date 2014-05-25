require 'test_helper'
include TestConstants::YAML

describe 'Config' do

  context 'config file does not exist' do

    it 'should throw error' do
      expect {Configuration.load_yaml(StringIO.new)}.to raise_error(InvalidConfigFormat)
    end

  end

  context 'config file exists' do

    describe 'when getting sleep' do

      it 'should throw error when sleep not correct format' do
        file = StringIO.new(INVALID_SLEEP_YAML)
        expect{Configuration.load_yaml(file)}.to raise_error(InvalidConfigFormat)
      end

      it 'should return sleep' do
        file = StringIO.new(VALID_YAML)
        config = Configuration.load_yaml(file)

        expect(config.get_sleep_time).to eq(VALID_SLEEP)
      end

    end

    it 'should return url' do
      file = StringIO.new(VALID_YAML)
      config = Configuration.load_yaml(file)

      expect(config.get_url).to eq(VALID_URL)
    end

    it 'should return useAuth' do
      file = StringIO.new(VALID_YAML)

      config = Configuration.load_yaml(file)

      expect(config.get_sleep_time).to eq(VALID_SLEEP)
    end

    it 'should return username' do
      file = StringIO.new(VALID_YAML)
      config = Configuration.load_yaml(file)

      expect(config.get_sleep_time).to eq(VALID_SLEEP)
    end

    it 'should return password' do
      file = StringIO.new(VALID_YAML)
      config = Configuration.load_yaml(file)

      expect(config.get_sleep_time).to eq(VALID_SLEEP)
    end

  end

end