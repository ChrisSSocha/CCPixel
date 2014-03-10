require 'test_helper'
require 'open-uri'

describe 'CCInput' do

  let(:invalid_url) {"invalid"}

  it 'constructor should throw exception if invalid url' do
    expect{CCInput.new(invalid_url)}.to raise_error(InvalidUrl)
  end

  describe '.fetch' do

    let(:valid_url) {"http://not.a.real.website.com"}

    it 'should throw exception if url does not exist' do
      ccInput = CCInput.new(valid_url)
      expect{ccInput.fetch()}.to raise_error(InvalidCCTrayFormat)
    end

    it 'should throw exception if document is not correct format' do
      ccInput = CCInput.new(valid_url)
      allow(ccInput).to receive(:open).and_return(StringIO.new)
      expect{ccInput.fetch()}.to raise_error(InvalidCCTrayFormat)
    end

    it 'should return xml string' do
      ccInput = CCInput.new(valid_url)
      document = StringIO.new(TestConstants::XML::OneProject)
      allow(ccInput).to receive(:open).and_return(document)

      expect(ccInput.fetch()).to eq(TestConstants::XML::OneProject)
    end

  end

end