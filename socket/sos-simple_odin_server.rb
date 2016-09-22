require 'socket'
require 'json'

server = TCPServer.new('localhost', 2345)

loop do
	socket     = server.accept
	
	begin
   request    = socket.read_nonblock(256).split("\r\n")
	rescue IO::WaitReadable
   IO.select([socket])
   retry
	end
	
	first_line = request[0].split(" ")
	file       = first_line[1][1..-1]				#filename without "/"

	STDERR.puts "*** this is server diagnostics ***"							+
			 				"request:\n#{request}\n"							+
							"first line:\n#{first_line}\n"	+
							"file: #{file}\n"											+
							"file exists? #{File.exist?(file)}\n"	+
							"*** server diagnostics finished ***"

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
			#socket.print "server says: that's the request:\n#{request}"
			#socket.print page
			params = JSON.parse(request[2])
			li_s = ''
			params["viking"].each { |key, value| li_s += "<li>#{key.capitalize}: #{value}</li>" }
			socket.puts "#{File.open(file).read.gsub("<%= yield %>", li_s)}"
			#socket.print "viking's data: #{params}"
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