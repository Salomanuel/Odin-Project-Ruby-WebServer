=begin
# http://www.tutorialspoint.com/ruby/ruby_socket_programming.htm
require 'socket'

server = TCPServer.new('localhost',3000)			#socket to that port

loop {
		request = server.accept.gets
		# => puts request
		server.accept.puts(Time.now.ctime)
		server.accept.puts "fuck off now"
		server.accept.close
}
=end

require 'socket'
require 'uri'


server = TCPServer.new('localhost', 2345)

loop do
	socket       = server.accept
	request_line = socket.gets.split(" ")

	STDERR.puts request_line

	if request_line[0] == "GET" and request_line[1] == "/index.html"
		message = File.read(request_line[1])
		socket.print 	"HTTP/1.1 200 OK\r\n" +
									#"Content-Type: #{content_type(message)}\r\n"
									#"Content-Lenght: #{message.size}\r\n" +
									"Connection: close\r\n"
			socket.print "\r\n"
		socket.print 	message
	else
		socket.print 	request_line
		socket.print 	"\nthis is #{request_line[1]}"
	end

	socket.close
end