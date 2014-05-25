require 'kwalify'
require_relative '../../src/exceptions/invalid_config_format'

class Configuration
  include Kwalify::Util::HashLike  # defines [], []=, and keys?
  attr_writer :url, :sleep, :auth

  def getUrl
    return @url
  end

  def getSleepTime
    return @sleep
  end

  def useAuth?
    return @auth['enabled']
  end

  def getUsername
    return @auth['username']
  end

  def getPassword
    return @auth['password']
  end

  def self.load_yaml(file)
    parser = getParser

    config = parser.parse(file.read())
    checkForErrors(parser)

    return config
  end

  private

    def self.checkForErrors(parser)
      errors = parser.errors()

      if errors && !errors.empty?
        raise InvalidConfigFormat, errors
      end
    end

    def self.getParser
      schemaFile = File.join(File.dirname(__FILE__), '..', 'resources', 'schema.yml')
      schema = Kwalify::Yaml.load_file(schemaFile)
      validator = Kwalify::Validator.new(schema)

      parser = Kwalify::Yaml::Parser.new(validator)
      parser.data_binding = true
      return parser
    end

end