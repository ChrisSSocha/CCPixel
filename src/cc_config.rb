require 'yaml'

require_relative 'exceptions/no_file_error'
require_relative 'exceptions/resource_not_found_error'
require_relative 'exceptions/invalid_auth_format_error'

class CCConfig

  def initialize(file)
    @yamlFile = load(file)
  end

  def getUrl
    url = @yamlFile['url']

    validateNotNil!(url)
    validateUrl!(url)

    return url
  end

  def getSleepTime
    sleepTimer = @yamlFile['sleep']

    validateNotNil!(sleepTimer)
    validateNumeric!(sleepTimer)

    return sleepTimer
  end

  def getAuth
    auth = @yamlFile['auth']

    if auth.nil?
      return nil
    end

    validateNotNil!(auth['user'])
    validateNotNil!(auth['pass'])

    return auth
  end

  private

    def validateNotNil!(resource)
      raise ResourceNotFoundError if resource.nil?
    end

    def validateUrl!(url)
      raise InvalidUrlError unless url =~ URI::regexp
    end

    def validateNumeric!(number)
      raise TypeError unless number.is_a? Numeric
    end

    def load(file)
      begin
        yamlFile = YAML.load_file(file)
      rescue Errno::ENOENT => e
        raise NoFileError, e
      end

      return yamlFile
    end

end