#!/bin/bash

echo "Enter secret passphrase"
read secret
echo "Enter irc password"
read irc_password

sh -c "weechat --no-connect --run-command '\
    /secure passphrase $secret;\
    /quit'"

# Freenode
sh -c "weechat --no-connect --run-command '\
    /server add freenode chat.freenode.net;\
    /set irc.server.freenode.addresses \"chat.freenode.net/7000\";\
    /set irc.server.freenode.username \"caulagi\";\
    /set irc.server.freenode.realname \"Pradip Caulagi\";\
    /set irc.server.freenode.nicks \"caulagi,caulagi_\";\
    /set irc.server.freenode.ssl on;\
    /set irc.server.freenode.autoconnect on;\
    /secure set irc_password $irc_password;\
    /set irc.server.freenode.sasl_username \"caulagi\";\
    /set irc.server.freenode.sasl_password \"\${sec.data.irc_password}\";\
    /set irc.server.freenode.autojoin \"#erlang\";\
    /quit'"

# Mozilla
sh -c "weechat --no-connect --run-command '\
    /server add mozilla irc.mozilla.org;\
    /set irc.server.mozilla.addresses \"irc.mozilla.org/6697\";\
    /set irc.server.mozilla.username \"caulagi\";\
    /set irc.server.mozilla.realname \"Pradip Caulagi\";\
    /set irc.server.mozilla.nicks \"caulagi,caulagi_\";\
    /set irc.server.mozilla.ssl on;\
    /set irc.server.mozilla.autoconnect on;\
    /secure set irc_password $irc_password;\
    /set irc.server.mozilla.sasl_username \"caulagi\";\
    /set irc.server.mozilla.sasl_password \"\${sec.data.irc_password}\";\
    /set irc.server.mozilla.autojoin \"#rust,#rust-beginners\";\
    /quit'"

