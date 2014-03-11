require 'yaml'

require_relative 'exceptions/no_file_error'
require_relative 'exceptions/resource_not_found_error'

class CCConfig

  def initialize(file)
    @yamlFile = load(file)
  end

  def getUrl
    url = @yamlFile['url']

    raise ResourceNotFoundError if url.nil?
    raise InvalidUrlError unless url =~ URI::regexp

    return url
  end

  def getSleepTime
    sleepTimer = @yamlFile['sleep']

    raise ResourceNotFoundError if sleepTimer.nil?
    raise TypeError unless sleepTimer.is_a? Numeric

    return sleepTimer
  end

  private

    def load(file)
      begin
        yamlFile = YAML.load_file(file)
      rescue Errno::ENOENT => e
        raise NoFileError, e
      end

      return yamlFile
    end

end