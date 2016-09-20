require 'socket'

server = TCPServer.new('localhost', 2345)


loop do
	socket  = server.accept
	request = socket.gets.split(" ")

	STDERR.puts request

	request_line  = "request was #{request}"
	request_line2 = "#{request} was requested"

	if request[0] == "GET" and request[1] == "/index.html"
		page = File.read("index.html")
		socket.print "HTTP/1.1 200 OK\r\n" 											 		+
								 "Content-Type: 	text/html\r\n" 				 			+
								 "Content-Lenght: #{page.bytesize}\r\n"+
								 "Connection: 		close\r\n"
		socket.print "\r\n"
		socket.print page
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