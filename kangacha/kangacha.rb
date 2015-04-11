require 'uri'
require 'net/http'

uri        = URI.parse "http://ctfq.sweetduet.info:10080/~q31/kangacha.php"
known_ship = "1"
known_sign = "24b7447578c89ea8f5f8854d60e253f23bb5b8856d8a135c19af423db354ac60a1a4c932cecd800a0550211e8cc6e28e73e1ac93e7b9c786adc24702e48701c5"
add_data   = "%2C10"
trials     = 50

http = Net::HTTP.new uri.host, uri.port
http.start {
	failed = http.get(uri.path).body

	(5..trials).each do |i|
		hashdump = `hashpump -s #{known_sign} -d #{known_ship} -a #{add_data} -k #{i}`
		sign, data = hashdump.split "\n"

		# data をいい感じに処理

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
