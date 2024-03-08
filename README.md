## Basic Discord bot
This repo has boilerplate code for a Ruby Discord bot written with discordrb. This bot will run on an AWS t3.micro instance and it should also run on a t3.nano or Pi Zero or similar (but it is untested).

### Creating the bot
This are the instructions for creating a Discord bot and running it on your system.

1) Go to https://discord.com/developers/applications.
2) Click `New Application` at the top right.
3) Give your bot a name and read and agree to the T&C.
4) Give your bot a picture and a description (optional).
5) Go to `OAuth2`.
6) Make a note of `Client ID` - this is your bot's user ID.
7) Under `OAuth2 URL Generator`, select scope `bot` (second column, sixth row) and your permissions.
8) Copy the URL at the bottom of the page and open it - this will invite it to your server.
9) Go to `Bot`.
10) Get the `Bot Token` - it should be 72 characters and have a couple of `.` and a `-`. If you lose this you will have to request a new one and restart your bot. It is essentially your bot's password.
11) Go to `App Testers` and add some friends to test your bot (optional).
12) Copy your bot token and ID into main.rb OR (better) save to a .env file or similar.
13) Run main.rb in the terminal or set up a systemd service (Linux only).
14) Your bot should now be running.

### Adding new commands
The commands `/text_repeater` will repeat phrases. The command shows the syntax for requiring strings, numbers, and booleans.
When you create a new slash command, copy one of the files in `/commands/`. You need to register the command and update the code which runs the function. Change the names of the functions (there is a string and two symbols for defining the functions themselves). When `main.rb` is reloaded, all slash commands will be added automatically via the functions in `module_loader.rb`.

### Sensitive commands
Some commands have `user_id` listed in an array - you should replace this with an list of user IDs who are allowed to use these functions.
