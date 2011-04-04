#!/bin/sh
ssh-agent | grep -v echo > "${HOME}/.ssh/agent-env"
. "${HOME}/.ssh/agent-env"
ssh-add
echo "please type:"
echo ". ~/.ssh/agent-env"
