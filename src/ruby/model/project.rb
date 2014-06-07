class Project

  attr_reader :name, :activity, :last_build_status, :last_build_label, :last_build_time, :next_build_time, :web_url

  module Constants
    module Activity
      SLEEPING = 'Sleeping'
      BUILDING = 'Building'
      CHECKING_MODIFICATIONS = 'CheckingModifications'
    end

    module LastBuildStatus
      PENDING = 'Pending'
      SUCCESS = 'Success'
      FAILURE = 'Failure'
      EXCEPTION = 'Exception'
      UNKNOWN = 'Unknown'
    end
  end

  class Builder

    def initialize(name, activity)
      @name = name
      @activity = activity
    end

    def last_build_status(last_build_status)
      @last_build_status = last_build_status
      self
    end

    def last_build_label(last_build_label)
      @last_build_label = last_build_label
      self
    end

    def last_build_time(last_build_time)
      @last_build_time = last_build_time
      self
    end

    def next_build_time(next_build_time)
      @next_build_time = next_build_time
      self
    end

    def web_url(web_url)
      @web_url = web_url
      self
    end

    def build
      Project.new(@name, @activity, @last_build_status, @last_build_label, @last_build_time, @next_build_time, @web_url)
    end

  end

  def ==(o)
    @name == o.name &&
      @activity == o.activity &&
      @last_build_status == o.last_build_status &&
      @last_build_label == o.last_build_label &&
      @last_build_time == o.last_build_time &&
      @next_build_time == o.next_build_time &&
      @web_url == o.web_url
  end

  def hash
    hash = 56
    hash = 73 * hash + @name
    hash = 73 * hash + @activity
    hash = 73 * hash + @last_build_status
    hash = 73 * hash + @last_build_label
    hash = 73 * hash + @last_build_time
    hash = 73 * hash + @next_build_time
    hash = 73 * hash + @web_url
    hash
  end

  def is_building?
    activity == Constants::Activity::BUILDING
  end

  def is_successful?
    last_build_status == Constants::LastBuildStatus::SUCCESS
  end

  private

    attr_writer :name, :activity, :last_build_status, :last_build_label, :last_build_time, :next_build_time, :web_url

    def initialize(name, activity, last_build_status, last_build_label, last_build_time, next_build_time, web_url)
      @name = name
      @activity = activity
      @last_build_status = last_build_status
      @last_build_label = last_build_label
      @last_build_time = last_build_time
      @next_build_time = next_build_time
      @web_url = web_url
    end

end