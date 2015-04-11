require 'uri'
require 'net/http'
require 'execjs'

uri        = URI.parse "http://ctfq.sweetduet.info:10080/~q31/kangacha.php"
known_ship = "1;"
known_sign = "24b7447578c89ea8f5f8854d60e253f23bb5b8856d8a135c19af423db354ac60a1a4c932cecd800a0550211e8cc6e28e73e1ac93e7b9c786adc24702e48701c5"
add_data   = "ship=10"
trials     = 50

http = Net::HTTP.new uri.host, uri.port
http.start {
	failed = http.get(uri.path).body

=begin
	known_header = {
		'Cookie' => "ship=#{known_ship}; signature=#{known_sign}"
	}
	puts http.get(uri.path, known_header).body
=end

	(5..trials).each do |i|
		hashpump = `hashpump -s #{known_sign} -d "#{known_ship}" -a "#{add_data}" -k #{i}`
		sign, data = hashpump.split "\n"

		# この data さえうまく処理できればいけそうたぶん
		data = ExecJS.eval %(encodeURIComponent("#{data}"))

		header = {
			'Cookie' => "ship=#{data}; signature=#{sign}"
		}
		response = http.get uri.path, header

		if response.body != failed
			puts "Trial #{i}: succeeded!"
			puts response.body
			break
		else
			puts "Trial #{i}: failed"
		end
	end
}
