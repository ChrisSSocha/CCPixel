require 'rspec'

require 'test_constants'

# Model
require_relative '../src/ruby/model/project'
require_relative '../src/ruby/model/configuration'

# Logic
require_relative '../src/ruby/build_monitor'
require_relative '../src/ruby/build_processor'
require_relative '../src/ruby/pipeline_web_resource'
require_relative '../src/ruby/pipeline_xml_parser'

# Exceptions
require_relative '../src/ruby/exceptions/invalid_ccxml_format_error'
require_relative '../src/ruby/exceptions/resource_not_found_error'
require_relative '../src/ruby/exceptions/invalid_url_error'
require_relative '../src/ruby/exceptions/no_file_error'
require_relative '../src/ruby/exceptions/invalid_config_format'