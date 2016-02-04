#!/bin/sh
# inc.util.sh

yellow(){
	printf "\033[1;33m$@\033[m"
}

red(){
	printf "\033[1;31m$@\033[m"
}

grape(){
	printf "\033[1;35m$@\033[m"
}

info(){
	echo "$(yellow '[INFO]') $@" 1>&2
}

warn(){
	echo "$(red '[WARN]') $@" 1>&2
}

debug(){
	echo_opts=""
	if [ "$1" = "-n" ]; then
		echo_opts="-n"
		shift
	fi
	if [ ! "$QUIET" = "true" -a "$DEBUG" = "true" ]; then
		echo $echo_opts "[DEBUG] $@" 1>&2
	fi
}

expected_params(){
	expected=$1; shift 1
	if [ ! "$#" -ge "$expected" ]; then
		warn "Bad syntax"
		exit 1
	fi
}

halt(){
	warn "Exiting..."
	exit 1
}

tmp_dir(){
	tmp_dir=$KDIR/tmp
	mkdir -p $tmp_dir
	echo $tmp_dir
}

cd_back(){
	cd - > /dev/null
}

download(){
	debug "Downloading $1"
	curl -s -k -L "$1" > $2
}

arg_name(){
  echo "$@" | sed 's/--\([^=]*\).*/\1/'
}

arg_value(){
  echo "$@" | sed 's/--[^=]*=\(.*\)/\1/'
}

is_arg(){
  prefix=`echo "$@" | sed 's/\(--\).*/\1/'`
  if [ "$prefix" = "--" ]; then
    echo 1
  else
    echo 0
  fi
}
