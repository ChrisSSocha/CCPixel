require 'rufus-scheduler'

class Scheduler < Rufus::Scheduler

  @@logger = Logger.new(STDOUT)

  def on_error(job, error)
    @@logger.debug("Intercepted error in scheduled job: #{error.inspect}")
  end

end