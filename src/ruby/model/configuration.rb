require 'kwalify'
require_relative '../exceptions/invalid_config_format'

class Configuration
  include Kwalify::Util::HashLike  # defines [], []=, and keys?
  attr_writer :url, :sleep, :auth

  def get_url
    @url
  end

  def get_sleep_time
    @sleep
  end

  def use_auth?
    @auth['enabled']
  end

  def get_username
    username = nil

    if use_auth?
      username = @auth['username']
    end

    username
  end

  def get_password
    password = nil

    if use_auth?
      password = @auth['password']
    end

    password
  end

  def self.load_yaml(file)
    parser = get_parser

    config = parser.parse(file.read)
    check_for_errors(parser)

    return config
  end

  private

    def self.check_for_errors(parser)
      errors = parser.errors

      if errors && !errors.empty?
        raise InvalidConfigFormat, errors
      end
    end

    def self.get_parser
      schema_file = File.join(File.dirname(__FILE__), '..', '..', 'resources', 'schema.yml')
      schema = Kwalify::Yaml.load_file(schema_file)
      validator = Kwalify::Validator.new(schema)

      parser = Kwalify::Yaml::Parser.new(validator)
      parser.data_binding = true
      return parser
    end

end