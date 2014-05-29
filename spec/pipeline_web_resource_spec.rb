require 'test_helper'
require 'open-uri'

describe 'PipelineWebResource' do

  let(:invalid_url) {"invalid"}
  let(:valid_url) {"http://not.a.real.website.com"}

  it 'constructor should throw exception if invalid url' do
    expect{PipelineWebResource.new(invalid_url)}.to raise_error(InvalidUrlError)
  end

  describe '.fetch' do

    it 'should throw exception if url does not exist' do
      input = PipelineWebResource.new(valid_url)
      expect{input.fetch}.to raise_error(InvalidCCXMLFormatError)
    end

    it 'should throw exception if document is not correct format' do
      ccInput = PipelineWebResource.new(valid_url)
      allow(ccInput).to receive(:open).and_return(StringIO.new)
      expect{ccInput.fetch}.to raise_error(InvalidCCXMLFormatError)
    end

    it 'should return xml string' do
      input = PipelineWebResource.new(valid_url)
      document = StringIO.new(TestConstants::XML::ONE_PROJECT)
      allow(input).to receive(:open).with(valid_url).and_return(document)

      expect(input.fetch).to eq(TestConstants::XML::ONE_PROJECT)
    end

  end

  context 'with auth details' do

    let(:username) {"username"}
    let(:password) {"password"}

    it 'should return xml string' do
      input = PipelineWebResource.new(valid_url, username, password)
      document = StringIO.new(TestConstants::XML::ONE_PROJECT)
      allow(input).to receive(:open).with(valid_url, http_basic_authentication: [username, password]).and_return(document)

      expect(input.fetch).to eq(TestConstants::XML::ONE_PROJECT)
    end
  end

end