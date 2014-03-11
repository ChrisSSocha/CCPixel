require 'open-uri'

require_relative 'exceptions/invalid_cc_tray_format_error'
require_relative 'exceptions/resource_not_found_error'
require_relative 'exceptions/invalid_url_error'

class CCInput

  def initialize(url)
    raise InvalidUrlError unless url =~ URI::regexp
    @url = url
  end

  def fetch()
    begin
      document = open(@url).read()
      validate!(document)
    rescue OpenURI::HTTPError => e
      raise ResourceNotFoundError, ["Error trying to fetch resource", e]
    end

    document

  end

  private

    def validate!(document)
      schema = Nokogiri::XML::Schema(File.read("#{File.expand_path("..", __FILE__)}/resources/cctray_schema.xsd"))

      xml_document = Nokogiri::XML::Document.parse(document)
      errors = schema.validate(xml_document)

      raise InvalidCCTrayFormatError unless errors.empty?
    end

end