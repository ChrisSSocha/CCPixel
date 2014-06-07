require 'logger'

$logger = Logger.new(STDOUT)
$logger.sev_threshold = Logger::INFO
