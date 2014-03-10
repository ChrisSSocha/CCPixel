require 'open-uri'

require_relative 'resource_not_found_error'
require_relative 'invalid_cc_tray_format'
require_relative 'invalid_url'

class CCInput

  #def initialize(openUri)
  #  @openUri = openUri
  #end

  def fetch(url)

    raise InvalidUrl unless url =~ URI::regexp

    begin
      document = open(url)
      validate(document)
    rescue OpenURI::HTTPError => e
      raise ResourceNotFoundError, ["Error trying to fetch resource", e]
    end

    document

  end

  private

    def validate(document)
      schema = Nokogiri::XML::Schema(File.read("#{File.expand_path("..", __FILE__)}/cctray_schema.xsd"))

      xml_document = Nokogiri::XML(document)
      errors = schema.validate(xml_document)

      raise InvalidCCTrayFormat unless errors.empty?
    end

end