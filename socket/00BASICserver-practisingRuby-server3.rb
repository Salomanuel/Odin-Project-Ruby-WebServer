require 'socket'

server = TCPServer.new('localhost', 2345)

loop do
	socket  = server.accept
	request = socket.gets				#reads the first line
	STDERR.puts request
	response = "Hello World!\n"

	socket.print 	"HTTP/1.1 200 OK\r\n" 	#HEADERS										+
								"Content-Type  : text/plain\r\n" 						+
								"Content-Length: #{response.bytesize}\r\n"	+
								"Connection    : close\r\n"

	socket.print "\r\n"					#blank line to separate the header from 
	socket.print response				#the body, required from protocol
	socket.close
end