require 'socket'
require 'json'

@host = 'localhost'
port = 2345
@path = '/'

def interface
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
	params = {:viking => {name: "", email:""}}
	puts "viking's name?"
	params[:viking][:name]  = gets.chomp
	puts "viking's email?"
	params[:viking][:email] = gets.chomp
	@additional_data = params.to_json
	@headers =  "Content-Lenght:#{@additional_data.size}\r\n\r\n"
end

interface

@first_line      = "#{@get_or_post} #{@path} HTTP/1.0\r\n\r\n"
@headers         = ""
@additional_data = ""

post if @get_or_post == "POST"

request = "#{@first_line}#{@headers}#{@additional_data}"

socket  = TCPSocket.open(@host,port)					#connect to server
socket.print(request)													#send request's first line
puts request

response = socket.read
headers, body = response.split("\r\n\r\n", 2)
puts body
socket.close																	#close the connection