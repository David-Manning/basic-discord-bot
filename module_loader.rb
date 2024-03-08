# module_loader.rb
module BotFunctions
	module ModuleLoader
		def self.register_and_include_commands(bot, namespace)
			namespace.constants.each do |module_name|
				mod = namespace.const_get(module_name)

				if mod.respond_to?(:register_commands)
					puts "Registering commands for #{module_name}"
					mod.register_commands(bot)
				end

				if mod.is_a?(Discordrb::EventContainer)
					puts "Including module: #{module_name}"
					bot.include!(mod)
				end
			end
		end
	end
end
