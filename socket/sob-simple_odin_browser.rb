require 'socket'

@host = 'localhost'
port = 2345
@path = '/'

def pages_options
	puts "what's page you want to reach in #{@host}'s domain?"
	puts "1 for index.html, 2 for thanks.html, 3 for custom"
	case gets.chomp
	when "1" then @path << "index.html"
	when "2" then @path << "thanks.html"
	when "3" then puts "write the page you want"; @path << gets.chomp
	else 
		@path << "index.html"
	end
		
	puts "1 for GET, 2 for POST (default is GET)"
	case gets.chomp
	when "1" then @get_or_post = "GET"
	when "2" then @get_or_post = "POST"
	else 				
		@get_or_post = "GET"
	end
end

def post

end

pages_options
#post if @get_or_post == "POST"
request = "#{@get_or_post} #{@path} HTTP/1.0\r\n\r\n"

socket  = TCPSocket.open(@host,port)
socket.print(request)
response = socket.read
headers, body = response.split("\r\n\r\n", 2)
puts body