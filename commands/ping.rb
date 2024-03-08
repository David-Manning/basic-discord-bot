# Function that replies with no inputs
# Useful for checking if the bot is online


module BotFunctions
	module Modules
		module PingCommand
			extend Discordrb::EventContainer

			# Register command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "ping"
				puts "Checking ping command"
				if bot.get_application_commands().any? { |c| c.name.downcase == fun_name.downcase }
					puts "#{fun_name} command found - skipping registration"
				else
					puts "#{fun_name} command not found - registering with Discord"
					bot.register_application_command(:ping, "Replies to the user.") do |cmd|
					# Usually put parameters in here
					end
				end

			end

			# Actual command
			application_command(:ping) do |event|
			    event.respond(content: "pong!")
			end


		end
	end
end

