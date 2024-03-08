# Function that rolls a die
# Useful for making life-changing decisions


module BotFunctions
	module Modules
		module DiceRoll
			extend Discordrb::EventContainer
			# Register the command
			def self.register_commands(bot)
				# Check if it is already registered
				# I use .downcase on the command name - remove this if you change capitalisation of commands
				fun_name = "dice_roll"
				puts "Checking #{fun_name} command"
				if bot.get_application_commands().any? { |c| c.name.downcase == fun_name.downcase }
					puts "#{fun_name.downcase} command found - skipping registration"
				else
					puts "#{fun_name.downcase} command not found - registering with Discord"
					bot.register_application_command(:dice_roll, "Rolls the dice") do |cmd|
						cmd.integer("dice_size", "How big your dice are (minimum 2)", required: true)
						cmd.integer("number_of_dice", "How many dice you want to roll (minimum of 1)", required: true)
					end
				end
			end

		# Code for the actual function
			application_command(:dice_roll) do |event|
				# Fetch inputs
				dice_size = event.options["dice_size"].to_i
				number_of_dice = event.options["number_of_dice"].to_i

				# Roll the dice
				if number_of_dice < 1
					event.respond(content: "You must roll at least 1 die")
				
				elsif dice_size < 2
					event.respond(content: "Minimum dice size is 2")

				else
					rolls = []
					number_of_dice.times do
						roll = rand(1..dice_size)
						rolls << roll
					end
					# Send the response
					event.respond(content: "User #{event.user.display_name} rolled a D#{dice_size.to_s} #{number_of_dice.to_s} #{number_of_dice == 1 ? 'time' : 'times'}.\nRolls: #{rolls.join(", ")}\nTotal score: #{rolls.sum.to_s}")
				end
			end
		end
	end
end