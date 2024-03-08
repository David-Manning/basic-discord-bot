# Function that allows people to assign themselves a role
# Useful for giving access to channels or pings

module BotFunctions
	module Modules
		module SelfToggleRole
			extend Discordrb::EventContainer
			# Register the command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "self_toggle_role"
				puts "Checking #{fun_name} command"
				if bot.get_application_commands().any? { |c| c.name.downcase == fun_name.downcase }
					puts "#{fun_name.downcase} command found - skipping registration"
				else
					puts "#{fun_name.downcase} command not found - registering with Discord"
				    bot.register_application_command(:self_toggle_role, "Toggle your own roles") do |cmd|
				        cmd.role("role", "The role to toggle", required: true)
				    end
				end
			end



		    # Code for the actual function
		    application_command(:self_toggle_role) do |event|
		        role = event.options["role"].to_i
		        role = event.server.roles.find { |r| r.id == role }
		        
				if role.nil? || role == false
					event.respond(content: "Role not found")

				elsif !["role1", "role2"].map(&:downcase).include?(role.name.downcase)
					event.respond(content: "#{role.name} role is not toggleable with this command")

				elsif event.user.role?(role)
					# Member already has the role, so remove it
					event.user.remove_role(role)
					event.respond(content: "Removed the #{role.name} role from #{event.user.name}")

				elsif !event.user.role?(role)
					# Member doesn't have the role, so add it
					event.user.add_role(role)
					event.respond(content: "Assigned the #{role.name} role to #{event.user.distinct}")

				else
					event.respond(content: "Unknown error - roles not changed")

				end

		    end

		end
	end
end




