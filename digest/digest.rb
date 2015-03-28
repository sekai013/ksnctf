require 'uri'
require 'net/http'
require 'digest/md5'

uri    = URI.parse 'http://ctfq.sweetduet.info:10080/~q9/flag.html'
hash1	 = "c627e19450db746b739f41b64097d449"
hash2  = Digest::MD5.hexdigest "GET:#{uri.path}"
nc     = "00000001"
cnonce = "9691c249745d94fc"
qop    = "auth"
uname  = "q9"
realm  = "secret"

http = Net::HTTP.new uri.host, uri.port
http.start {
	unauthorized = http.get uri.path
	nonce = unauthorized['WWW-Authenticate'].match(/nonce="(.*)",/) do |match|
		match[1]
	end

	response = Digest::MD5.hexdigest "#{hash1}:#{nonce}:#{nc}:#{cnonce}:#{qop}:#{hash2}"
	header = {
		"Authorization" => %(Digest username="#{uname}", realm="#{realm}", nonce="#{nonce}", uri="#{uri.path}", algorithm=MD5, response="#{response}", qop=#{qop}, nc=#{nc}, cnonce="#{cnonce}")
	}

	authorized = http.get uri.path, header
	p authorized.body
}
