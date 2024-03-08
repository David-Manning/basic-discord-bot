# Function that repeats a message n times
# Not very useful but here to demonstrate code elements


module BotFunctions
	module Modules
		module TextRepeater
			extend Discordrb::EventContainer
			# Register the command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "text_repeater"
				puts "Checking #{fun_name} command"
				if bot.get_application_commands().any? { |c| c.name.downcase == fun_name.downcase }
					puts "#{fun_name.downcase} command found - skipping registration"
				else
					puts "#{fun_name.downcase} command not found - registering with Discord"
					bot.register_application_command(:text_repeater, "Repeats text") do |cmd|
						cmd.string("message", "Message to repeat", required: true)
						cmd.integer("repeats", "How many times you want to repeat", required: true)
						cmd.boolean("with_fullstop", "Whether to display a full stop", required: false)
					end
				end
			end

		# Code for the actual function
			application_command(:text_repeater) do |event|
				# Fetch inputs
				puts event.to_s
				message = event.options["message"]
				repeats = event.options["repeats"]
				with_fullstop = event.options.fetch("with_fullstop", false) # To use false as default

				# Calculate output
				text = message * repeats
				text += "." if with_fullstop

				# Send the response
				event.respond(content: text)
			end
		end
	end
end