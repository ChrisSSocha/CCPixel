require 'rspec'

require 'test_contants'

# Model
require_relative '../src/model/project'

# Logic
require_relative '../src/cc_parser'
require_relative '../src/cc_input'
require_relative '../src/cc_output'
require_relative '../src/cc_pixel'
require_relative '../src/cc_config'

# Exceptions
require_relative '../src/exceptions/invalid_cc_tray_format_error'
require_relative '../src/exceptions/resource_not_found_error'
require_relative '../src/exceptions/invalid_url_error'
require_relative '../src/exceptions/no_file_error'