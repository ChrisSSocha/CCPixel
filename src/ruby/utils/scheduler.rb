require 'logger'
require 'rufus-scheduler'

class Scheduler < Rufus::Scheduler

  def on_error(job, error)
    $LOGGER.debug("Intercepted error in scheduled job: #{error.inspect}")
  end

end