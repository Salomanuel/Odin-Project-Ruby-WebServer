require 'socket'
require 'json'

server = TCPServer.new('localhost', 2345)

loop do
	socket     = server.accept
	request    = socket.read_nonblock(256)
	
	first_line = request.split("\r\n")[0].split(" ")
	file       = first_line[1][1..-1]				#filename without "/"

	STDERR.puts "*** this is server ***"							+
			 				"request:\n#{request}\n"							+
							"first line:\n#{first_line}\n"	+
							"file: #{file}\n"											+
							"file exists? #{File.exist?(file)}\n"	+
							"*** server is done***"


	#STDERR.puts "server request: #{request}"

	if File.exist?(file) 
		page = File.read(file)	
		socket.print "HTTP/1.1 200 OK\r\n" 											 		+
								 "Content-Type: 	text/html\r\n" 				 			+
								 "Content-Lenght: #{page.bytesize}\r\n"+
								 "Connection: 		close\r\n"
		socket.print "\r\n"
		if 		first_line[0] == "GET"
			socket.print page
		elsif first_line[0] == "POST"
			socket.print "server says: that's the request:\n#{request}"
			#socket.print page
		end
	else
		not_found  = "page not found, type better"								
		content 	 = "#{not_found}\n#{request[1][1..-1]}"
		socket.print "HTTP/1.1 404 Not Found\r\n" 											 		+
								 "Content-Type: 	text/plain\r\n" 				 			+
								 "Content-Lenght: #{content.bytesize}\r\n" +
								 "Connection: 		close\r\n"
		socket.print "\r\n"
		socket.print content
	end
	socket.close
end