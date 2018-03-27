require_relative 'config/environment'
require_relative 'lib/api_communicator'
require_relative 'lib/Command_Line_Interface'


new_cli = CommandLineInterface.new 
new_cli.run