# Function that deletes the last x messages in a channel (the same one you called it in).
# This gives an error

module BotFunctions
	module Modules
		module PurgeMessages
			extend Discordrb::EventContainer
			# Register the command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "purge_messages"
				puts "Checking #{fun_name} command"
				if bot.get_application_commands().any? { |c| c.name.downcase == fun_name.downcase }
					puts "#{fun_name.downcase} command found - skipping registration"
				else
					puts "#{fun_name.downcase} command not found - registering with Discord"
					bot.register_application_command(:purge_messages, "Deletes n messages in the ") do |cmd|
						cmd.integer("messages", "How many messages you want to remove", required: true)
					end
				end
			end

			application_command(:purge_messages) do |event|
			    amount = event.options["messages"].to_i
			    if amount < 1 
			    	event.respond(content: "Number of messages must be at least 1")
			    end
			    event.respond(content: "Deleting #{deleted} messages. Messages will disappear gradually due to the rate limit")
			    messages = event.channel.history(amount)#.map(&:itself)
			    deleted = event.channel.delete_messages(messages)
			    
			end

		end
	end
end


