require 'pathname'
require_relative 'onion'

begin
	puts 'Enter Path to the file you want to Base64 Encode/Decode.'
	path = Pathname.new gets.chomp

	if File.exist? path.expand_path.to_path
		str = File.read path.expand_path.to_path
	else
		raise ArgumentError
	end

	villager = Villager.new(str)
	villager.run
rescue => e
	puts e.message
end
