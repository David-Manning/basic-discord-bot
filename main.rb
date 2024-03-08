#!/usr/bin/env ruby
# Load gems
puts "Loading discordrb"
require "discordrb"

# Bot token
# This should be in your .env file or in some other secret location
# It is about 72 characters, has a couple of . and a -
puts "Loading bot token and ID"
bot_token = ""
bot_id = ""

# Create bot
# Might not want all these intents - server_messages: are essential, server_members: are used in some commands
puts "Creating bot object"
bot = Discordrb::Commands::CommandBot.new(token: bot_token,
                                          intents: [:servers,
                                                    :server_members,
                                                    :server_bans,
                                                    :server_emojis,
                                                    :server_integrations,
                                                    :server_webhooks,
                                                    :server_invites,
                                                    :server_voice_states,
                                                    :server_presences,
                                                    :server_messages,
                                                    :server_message_reactions,
                                                    :server_message_typing,
                                                    :direct_messages,
                                                    :direct_message_reactions,
                                                    :direct_message_typing])

# Load functions via a loop - this will pull in every .rb file in the /commands/ folder
puts "Loading commands"
Dir.glob(File.join(__dir__, "commands", "*.rb")).each do |file|
    require_relative file
end

# Clear old commands - useful for when testing or releasing a new version
# Usually want to comment this out when you are not testing or building
puts "Clearing old commands"
commands = bot.get_application_commands
commands.each do |cmd|
    bot.delete_application_command(cmd.id)
end


# Register and include all modules - this will import anything that is in ./commands/ - usually recovering what we just deleted
puts "Registering commands and including modules"
require_relative "module_loader"
BotFunctions::ModuleLoader.register_and_include_commands(bot, BotFunctions::Modules)

# Set the bot's status
bot.ready do
    bot.listening = "Bananarama"
end

# Run the bot
puts "Starting bot"
bot.run

