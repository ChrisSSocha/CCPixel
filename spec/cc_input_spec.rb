require 'test_helper'
require 'open-uri'

describe 'CCInput' do

  let(:invalid_url) {"invalid"}
  let(:valid_url) {"http://not.a.real.website.com"}

  it 'constructor should throw exception if invalid url' do
    expect{CCInput.new(invalid_url)}.to raise_error(InvalidUrlError)
  end

  describe '.fetch' do

    it 'should throw exception if url does not exist' do
      ccInput = CCInput.new(valid_url)
      expect{ccInput.fetch()}.to raise_error(InvalidCCTrayFormatError)
    end

    it 'should throw exception if document is not correct format' do
      ccInput = CCInput.new(valid_url)
      allow(ccInput).to receive(:open).and_return(StringIO.new)
      expect{ccInput.fetch()}.to raise_error(InvalidCCTrayFormatError)
    end

    it 'should return xml string' do
      ccInput = CCInput.new(valid_url)
      document = StringIO.new(TestConstants::XML::OneProject)
      allow(ccInput).to receive(:open).with(valid_url).and_return(document)

      expect(ccInput.fetch()).to eq(TestConstants::XML::OneProject)
    end

  end

  context 'with auth details' do

    let(:username) {"username"}
    let(:password) {"password"}

    it 'should return xml string' do
      ccInput = CCInput.new(valid_url, username, password)
      document = StringIO.new(TestConstants::XML::OneProject)
      allow(ccInput).to receive(:open).with(valid_url, http_basic_authentication: [username, password]).and_return(document)

      expect(ccInput.fetch()).to eq(TestConstants::XML::OneProject)
    end
  end

end