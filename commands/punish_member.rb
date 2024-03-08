# Function that punishes a user
# Useful for dealing with annoying people


module BotFunctions
	module Modules
		module PunishUser
			extend Discordrb::EventContainer

			# Register command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "punish_user"
				puts "Checking #{fun_name} command"
				if bot.get_application_commands().any? { |c| c.name.downcase == fun_name.downcase }
					puts "#{fun_name} command found - skipping registration"
				else
					puts "#{fun_name} command not found - registering with Discord"
					bot.register_application_command(:punish_user, "Replies to the user.") do |cmd|
						cmd.user("member", "The person you want to punish")
						cmd.string("punishment", "The punishment you want to deal out. Must be one of `ban`, `kick`, `mute`, or `deafen`")
					end
				end

			end

			# Actual command
			application_command(:punish_user) do |event|
				# Find user
				member = event.options["member"].to_i
	        	member = event.server.members.find { |m| m.id == member }

	        	# Find punishment
	        	punishment = event.options["punishment"].downcase.strip

				if member.nil? || member == false
					event.respond(content: "Member not found")

				elsif member.owner?
					event.respond(content: "You cannot kick the server owner")

				elsif ![user_id].include?(event.user.id) & event.user.id # Can also be managed by roles
					event.respond(content: "You do not have permission to do this")

				elsif punishment == "ban"
					event.respond(content: "User #{member.display_name} has been banned by #{member.display_name}!")
					member.ban

				elsif punishment == "kick"
					event.respond(content: "User #{member.display_name} has been kicked by #{member.display_name}!")
					member.kick

				elsif punishment == "mute"
					event.respond(content: "User #{member.display_name} has been muted by #{member.display_name}!")
					member.server_mute

				elsif punishment == "deafen" || punishment == "deaf"
					event.respond(content: "User #{member.display_name} has been deafened by #{member.dispaly_name}!")
					member.server_mute

				else
				    event.respond(content: "Unknown error - nothing has been done")
				end
			end
		end
	end
end

