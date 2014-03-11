require 'open-uri'

require_relative 'exceptions/invalid_cc_tray_format_error'
require_relative 'exceptions/resource_not_found_error'
require_relative 'exceptions/invalid_url_error'

class CCInput

  def initialize(url, authHash = nil)
    raise InvalidUrlError unless url =~ URI::regexp
    @url = url
    @authHash = authHash
  end

  def fetch()
    begin
      document = getDocument()
      validate!(document)
    rescue OpenURI::HTTPError => e
      raise ResourceNotFoundError, ["Error trying to fetch resource", e]
    end

    document

  end

  private

  def getDocument()

    if @authHash
      user = @authHash['user']
      pass = @authHash['pass']
      document = open(@url, http_basic_authentication: [user, pass])
    else
      document = open(@url)
    end

    document.read()
  end

    def validate!(document)
      schema = Nokogiri::XML::Schema(File.read("#{File.expand_path("..", __FILE__)}/resources/cctray_schema.xsd"))

      xml_document = Nokogiri::XML::Document.parse(document)
      errors = schema.validate(xml_document)

      raise InvalidCCTrayFormatError unless errors.empty?
    end

end