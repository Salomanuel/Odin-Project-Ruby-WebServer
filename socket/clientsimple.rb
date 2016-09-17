require 'socket'

hostname = 'localhost'
port     = 2000

s = TCPSocket.open(hostname, port)

while line = s.gets			#read lines from socket
	puts line.chomp				#and print with platform line terminator
end
s.close									#close the socket when done



