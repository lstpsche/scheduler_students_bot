# Scheduler Students Telegram Bot

Group chats are **not supported**!

### Start postgresql server

1) start postgresql server with <em>sudo</em>:
``` bash
sudo service postgresql start
```
2) enter your account password in <em>terminal prompt</em>.

## Rake tasks

You can run rake tasks.

#### Show all tasks
``` bash
bundle exec rake --tasks
```

## Run bot

Launch the following from the app root
``` bash
bundle exec ruby app.rb
```

## /start

If User is <em>not</em> registered -- launches registration dialog.

## /menu

If User is registered -- shows Main Menu.

## /help

Sends a help-message to chat, where `/help` was called. \
Message contains all described common commands.
