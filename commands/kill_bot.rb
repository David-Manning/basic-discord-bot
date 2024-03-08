# Function that switches off the bot
# Very useful for testing


module BotFunctions
	module Modules
		module KillBot
			extend Discordrb::EventContainer
			# Register the command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "kill_bot"
				puts "Checking #{fun_name} command"
				if bot.get_application_commands().any? { |c| c.name == fun_name.downcase }
					puts "#{fun_name} command found - skipping registration"
				else
					puts "#{fun_name} command not found - registering with Discord"
					bot.register_application_command(:kill_bot, "Replies to the user.") do |cmd|
						cmd.boolean("reboot", "Whether to reboot (defaults to true)", required: false)
					end
				end
			end

			# Code for the actual function
			application_command(:kill_bot) do |event|
				# Exit ruby - no way to restart so check that the person using it is in an approved list
				# Either specify user IDs here or check if server admin or if bot_admin role or similar
				if [user_id].include?(event.user.id)
					
					if event.options["reboot"] == false
						event.respond(content: "Switching off the bot")
						bot.stop
					else
						event.respond(content: "Rebooting the bot")
						bot.stop
						bot.run
					end
				else # Anyone not on the allow list
					event.respond(content: "You do not have permission to use this command!")
				end
			end
		end
	end
end

