require "socket"

class Client
	def initialize(server)
		@server   = server
		@request  = nil
		@response = nil
	end
end