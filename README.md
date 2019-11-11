# Scheduler Students Telegram Bot

[![Build Status](https://travis-ci.com/lstpsche/scheduler_students_bot.svg?branch=master)](https://travis-ci.com/lstpsche/scheduler_students_bot)
[![codebeat badge](https://codebeat.co/badges/0659ca62-2140-4227-b2d0-1a1fa01dac63)](https://codebeat.co/projects/github-com-lstpsche-scheduler_students_bot-master)

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
