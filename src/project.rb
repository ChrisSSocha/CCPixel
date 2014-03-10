class Project

  attr_reader :name, :activity, :lastBuildStatus, :lastBuildLabel, :lastBuildTime, :nextBuildTime, :webUrl

  module Constants
    module Activity
      SLEEPING = "Sleeping"
      BUILDING = "Building"
      CHECKING_MODIFICATIONS = "CheckingModifications "
    end

    module LastBuildStatus
      PENDING = "Pending"
      SUCCESS = "Success"
      FAILURE = "Failure"
      EXCEPTION = "Exception"
      UNKNOWN = "Unknown"
    end
  end

  class Builder

    def initialize(name, activity)
      @name = name
      @activity = activity
    end

    def lastBuildStatus(lastBuildStatus)
      @lastBuildStatus = lastBuildStatus
      self
    end

    def lastBuildLabel(lastBuildLabel)
      @lastBuildLabel = lastBuildLabel
      self
    end

    def lastBuildTime(lastBuildTime)
      @lastBuildTime = lastBuildTime
      self
    end

    def nextBuildTime(nextBuildTime)
      @nextBuildTime = nextBuildTime
      self
    end

    def webUrl(webUrl)
      @webUrl = webUrl
      self
    end

    def build
      Project.new(@name, @activity, @lastBuildStatus, @lastBuildLabel, @lastBuildTime, @nextBuildTime, @webUrl)
    end

  end

  def ==(o)
    @name == o.name &&
      @activity == o.activity &&
      @lastBuildStatus == o.lastBuildStatus &&
      @lastBuildLabel == o.lastBuildLabel &&
      @lastBuildTime == o.lastBuildTime &&
      @nextBuildTime == o.nextBuildTime &&
      @webUrl == o.webUrl
  end

  def hash
    hash = 56
    hash = 73 * hash + @name
    hash = 73 * hash + @activity
    hash = 73 * hash + @lastBuildStatus
    hash = 73 * hash + @lastBuildLabel
    hash = 73 * hash + @lastBuildTime
    hash = 73 * hash + @nextBuildTime
    hash = 73 * hash + @webUrl
    hash
  end

  def isBuilding?
    return activity == Constants::Activity::BUILDING
  end

  def isSuccessful?
    return lastBuildStatus == Constants::LastBuildStatus::SUCCESS
  end

  private

    attr_writer :name, :activity, :lastBuildStatus, :lastBuildLabel, :lastBuildTime, :nextBuildTime, :webUrl

    def initialize(name, activity, lastBuildStatus, lastBuildLabel, lastBuildTime, nextBuildTime, webUrl)
      @name = name
      @activity = activity
      @lastBuildStatus = lastBuildStatus
      @lastBuildLabel = lastBuildLabel
      @lastBuildTime = lastBuildTime
      @nextBuildTime = nextBuildTime
      @webUrl = webUrl
    end

end