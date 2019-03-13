#!/usr/bin/env bash

dotimeout() {
  if test -x "$(which timeout)"; then
    timeout "$@"
  else
    gtimeout "$@"
  fi
}

check_status() {
  case "$1" in
    '') case "$?" in
          0) printf 'ok\n';;
          *) printf 'not ok';;
        esac;;
    *)  case "$?" in
          0) printf 'ok %s\n' "$1";;
          *) printf 'not ok %s\n' "$1";;
        esac;;
  esac
}

printf '%s\n' 1..10

# check that we were called with a reasonable argv[0] (low signal)
cd "$(dirname "$0")"
check_status

# check that we were able to cd into parent directory (low signal)
cd ..
check_status

# check that the .git directory exists here, which is a good sign
test -d .git
check_status

# check that a directory called autoload exists here
test -d autoload
check_status

# check that an executable called "vim" exists (low signal)
test -x "$(which vim)"
check_status

# check that vim can execute (low signal)
dotimeout 1 vim --help 1>/dev/null 2>/dev/null
check_status

# check that the --clean option is supported
# tell vim explicitly that we are not writing a terminal
dotimeout 1 vim --not-a-term --clean --cmd 'exit'
check_status

# check that the script file exists
test -f ./t/justexit.vim
check_status

# check that vim can read commands from a file
dotimeout 1 vim --not-a-term --clean -s ./t/justexit.vim
check_status

# get data out of vim by having it print via system
#test "hi" "=" "$(dotimeout 1 vim --not-a-term --clean --cmd 'system("echo hi")
#exit')"
#check_status
