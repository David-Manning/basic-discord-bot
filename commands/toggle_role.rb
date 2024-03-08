# Function that allows admins and leaders to assign a specific role
# Can also hard code role if it is frequently used - e.g. /recruit command

module BotFunctions
	module Modules
		module ToggleRole
			extend Discordrb::EventContainer
			# Register the command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "toggle_role"
				puts "Checking #{fun_name} command"
				if bot.get_application_commands().any? { |c| c.name.downcase == fun_name.downcase }
					puts "#{fun_name.downcase} command found - skipping registration"
				else
					puts "#{fun_name.downcase} command not found - registering with Discord"
				    bot.register_application_command(:toggle_role, "Toggle someone's role") do |cmd|
				        cmd.user("member", "The person who will receive the role change", required: true)
				        cmd.role("role", "The role to assign", required: true)
				    end
				end
			end



		    # Code for the actual function
		    application_command(:toggle_role) do |event|

		    	member = event.options["member"].to_i
		        member = event.server.members.find { |m| m.id == member }
		        role = event.options["role"].to_i
		        role = event.server.roles.find { |r| r.id == role }

				if role.nil? || role == false
					event.respond(content: "Role not found")

				elsif ![user_id].include?(event.user.id) & event.user.id # Can also be managed by roles
					event.respond(content: "You do not have permission to do this")
				
				elsif member.role?(role)
					# Member already has the role, so remove it
					member.remove_role(role)
					event.respond(content: "Removed the #{role.display_name} role from #{member.display_name}")

				elsif !member.role?(role)
					# Member doesn't have the role, so add it
					member.add_role(role)
					event.respond(content: "Assigned the #{role.display_name} role to #{member.display_name}")

				else
					event.respond(content: "Unknown error - roles not changed")

				end

		    end

		end
	end
end




