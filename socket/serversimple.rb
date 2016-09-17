# http://www.tutorialspoint.com/ruby/ruby_socket_programming.htm
require 'socket'

server = TCPServer.open(2000)			#socket to that port
=begin
loop { 														#server runs forever
	client = server.accept					#wait for a client to connect
	client.puts(Time.now.ctime)			#send the time to the client
	client.puts "fuck off now"
	client.close										#disconnect from the client
}
=end
#MULTI-CLIENT
loop {
	Thread.start(server.accept) do |client|
		client.puts(Time.now.ctime)
		client.puts "fuck off now"
		client.close
	end
}
