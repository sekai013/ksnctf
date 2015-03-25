require 'pathname'

class Caesal

	def initialize(cipher_text)
		@cipher_text = cipher_text
	end

	def swap(a, b)
		@cipher_text = @cipher_text.gsub(a.upcase, '!').gsub(b.upcase, a.upcase).gsub('!', b.upcase)
		@cipher_text = @cipher_text.gsub(a.downcase, '!').gsub(b.downcase, a.downcase).gsub('!', b.downcase)
		puts @cipher_text
	end

	def run
		puts <<EOS
[Usage]
swap   , s <char_a> <char_b> :swap char_a and char_b
display, d                   :display cipher text
quit   , q                   :quit
EOS

		while true do
			print 'command>'
			command, a, b = gets.chomp.split ' '

			case command
			when 's', 'swap'
				continue if a.size != 1 and b.size != 1
				swap a, b
			when 'd', 'display'
				puts @cipher_text
			when 'q', 'quit'
				puts 'Bye'
				exit
			end
		end
	end

end

print 'Enter path to ciphertext: '
pathname = Pathname.new(gets.chomp).expand_path
if pathname.file?
	begin
		caesal = Caesal.new File.read pathname.to_path
		caesal.run
	rescue => e
		puts e.message
	end
else
	puts %(File doesn't exist)
end
