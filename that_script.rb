require 'net/http'
require 'bundler'
Bundler.require(:default)

TCPSocket.socks_password = ENV['PASSWORD']
TCPSocket.socks_username = ENV['USER']

url = ENV['URL'] || 'https://api.ipify.org'
uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = uri.scheme === 'https'

request = Net::HTTP::Get.new(uri.request_uri)

response = if ENV['IP'] != ''
  Socksify.proxy(ENV['IP'], ENV['PORT']) { http.request(request) }
else
  http.request(request)
end

puts "code: #{response.code}", "body: #{response.body}"