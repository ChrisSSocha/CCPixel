require 'logger'
require 'rufus-scheduler'

class Scheduler < Rufus::Scheduler

  def on_error(job, error)
    $logger.debug("Intercepted error in scheduled job: #{error.inspect}")
    shutdown
  end

end