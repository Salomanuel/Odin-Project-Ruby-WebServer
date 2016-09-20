require 'socket'

server = TCPServer.new('localhost', 2345)


loop do
	socket  = server.accept
	request = socket.gets.split(" ")

	STDERR.puts request

	request_line  = "request was #{request}"
	request_line2 = "#{request} was requested"
	not_found 		= "page not found, type better"

	if request[0] == "GET" and File.exist?request[1][1..-1]
		page = File.read(request[1][1..-1])		#filename without "/"
		socket.print "HTTP/1.1 200 OK\r\n" 											 		+
								 "Content-Type: 	text/html\r\n" 				 			+
								 "Content-Lenght: #{page.bytesize}\r\n"+
								 "Connection: 		close\r\n"
		socket.print "\r\n"
		socket.print page
	else								
		content = "#{not_found}\n#{request[1][1..-1]}"
		socket.print "HTTP/1.1 404 Not Found\r\n" 											 		+
								 "Content-Type: 	text/plain\r\n" 				 			+
								 "Content-Lenght: #{content.bytesize}\r\n" +
								 "Connection: 		close\r\n"
		socket.print "\r\n"
		socket.print content
	end
	socket.close
end