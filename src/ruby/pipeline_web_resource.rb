require 'open-uri'

require_relative 'exceptions/invalid_cc_tray_format_error'
require_relative 'exceptions/resource_not_found_error'
require_relative 'exceptions/invalid_url_error'

class PipelineWebResource

  def initialize(url, username = nil, password = nil)
    raise InvalidUrlError unless url =~ URI::regexp
    @url = url

    @username = username
    @password = password
  end

  def fetch()
    begin
      document = getDocument
      validate!(document)
    rescue OpenURI::HTTPError, Errno::ECONNREFUSED => e
      raise ResourceNotFoundError, ["Error trying to fetch resource", e]
    end

    document

  end

  private

    def getDocument()

      if @username && @password
        document = open(@url, http_basic_authentication: [@username, @password])
      else
        document = open(@url)
      end

      document.read
    end

    def validate!(document)
      schema_file = File.join(File.dirname(__FILE__), '..', 'resources', 'cctray_schema.xsd')
      schema = Nokogiri::XML::Schema(File.read(schema_file))

      xml_document = Nokogiri::XML::Document.parse(document)
      errors = schema.validate(xml_document)

      raise InvalidCCTrayFormatError unless errors.empty?
    end

end