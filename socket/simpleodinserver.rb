require 'socket'

server = TCPServer.new('localhost', 2345)


loop do
	socket  = server.accept
	request = socket.gets.split(" ")

	STDERR.puts request

	request_line  = "request was #{request}"
	request_line2 = "#{request} was requested"

	if request[0] == "GET" and request[1] == "/index.html"
		socket.print "HTTP/1.1 200 OK\r\n" 											 		+
								 "Content-Type: 	text/plain\r\n" 				 			+
								 "Content-Lenght: #{request_line2.bytesize}\r\n"+
								 "Connection: 		close\r\n"
		socket.print "\r\n"
		socket.print "will show index.html"
	else								
		socket.print "HTTP/1.1 200 OK\r\n" 											 		+
								 "Content-Type: 	text/plain\r\n" 				 			+
								 "Content-Lenght: #{request_line.bytesize}\r\n" +
								 "Connection: 		close\r\n"
		socket.print "\r\n"
		socket.print request_line
	end
	socket.close
end