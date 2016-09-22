require 'socket'
webserver = TCPServer.new('localhost', 7125)
while (session = webserver.accept)
	session.print "HTTP/1.1 200 OK\r\nContent-Type:text/html\r\n\r\n"
	request = session.gets
	trimmed_request = request.gsub(/GET\ \//, "").gsub(/\ HTTP.*/, "")
	filename = trimmed_request.chomp
	filename = "index.html" if filename == ""
	begin
		displayfile = File.open(filename, "r")
		content = displayfile.read()
		session.print content
	rescue Errno::ENOENT
		session.print "File not found"
	end
		session.close
end