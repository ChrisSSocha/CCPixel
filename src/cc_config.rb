require 'kwalify'

require_relative 'exceptions/no_file_error'
require_relative 'exceptions/resource_not_found_error'

class CCConfig

  def initialize(file)
    @yamlFile = load(file)
  end

  def getUrl
    url = @yamlFile['url']

    validateUrl!(url)

    return url
  end

  def getSleepTime
    sleepTimer = @yamlFile['sleep']

    validateNumeric!(sleepTimer)

    return sleepTimer
  end

  def useAuth?
    auth = @yamlFile['auth']
    return auth['enabled']
  end

  def getUsername
    auth = @yamlFile['auth']
    return auth['username']
  end

  def getPassword
    auth = @yamlFile['auth']
    return auth['password']
  end

  private

    def load(file)

      validator = getValidator()
      yamlFile = parseFile(file, validator)

      return yamlFile
    end

    def parseFile(file, validator)
      begin
        parser = Kwalify::Yaml::Parser.new(validator)
        yamlFile = parser.parse(file.read)
      rescue Errno::ENOENT => e
        raise NoFileError, e
      end

      errors = parser.errors()
      if errors && !errors.empty?
        raise InvalidConfigFormat
      end

      return yamlFile
    end

  def getValidator
    begin
      schemaFile = "#{File.expand_path("..", __FILE__)}/resources/schema.yml"
      schema = Kwalify::Yaml.load_file(schemaFile)
      return Kwalify::Validator.new(schema)
    rescue Errno::ENOENT => e
      raise NoFileError, e
    end
  end

    def validateUrl!(url)
      raise InvalidUrlError unless url =~ URI::regexp
    end

    def validateNumeric!(number)
      raise TypeError unless number.is_a? Numeric
    end

end
