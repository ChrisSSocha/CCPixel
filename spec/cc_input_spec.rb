require 'test_helper'
require 'open-uri'

describe '.fetch' do

  before(:each){
    @ccInput = CCInput.new
  }

  let(:invalid_url) {"invalid"}
  let(:valid_url) {"http://not.a.real.website.com"}

  it 'should throw exception if invalid url' do
    expect{@ccInput.fetch(invalid_url)}.to raise_error(InvalidUrl)
  end

  it 'should throw exception if url does not exist' do
    expect{@ccInput.fetch(valid_url)}.to raise_error(InvalidCCTrayFormat)
  end

  it 'should throw exception if document is not correct format' do
    allow(@ccInput).to receive(:open).and_return(nil)
    expect{@ccInput.fetch(valid_url)}.to raise_error(InvalidCCTrayFormat)
  end

  it 'should return xml string if valid url' do
    document = StringIO.new(TestConstants::XML::OneProject)
    allow(@ccInput).to receive(:open).and_return(document)

    expect(@ccInput.fetch(valid_url)).to eq(document)
  end

end