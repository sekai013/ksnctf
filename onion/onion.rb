require 'base64'

class Villager

	def initialize (str)
		@str = str
	end

	def run
		while(true)
			command_help = <<EOS
Enter Command: 
	encode[e]
	decode[d]
	show[s]
	quit[q]
EOS

			puts command_help
			print 'command> '
			command = gets.chomp

			case command
			when 'encode', 'e'
				@str = Base64.encode64 @str
				puts @str
			when 'decode', 'd'
				@str = Base64.decode64 @str
				puts @str
			when 'quit', 'q'
				puts 'Bye.'
				exit
			when 'show', 's'
				puts @str
			else
				puts 'Unknown Command'
			end
			puts
		end
	end

end
