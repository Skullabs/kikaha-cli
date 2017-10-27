#!/bin/sh
# inc.util.sh
TRUE=1
FALSE=0

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
	echo "$(yellow '::') $@" 1>&2
}

warn(){
	echo "$(red '::') $@" 1>&2
}

debug(){
	echo_opts=""
	if [ "$1" = "-n" ]; then
		echo_opts="-n"
		shift
	fi
	if [ ! "$QUIET" = "true" -a "$DEBUG" = "true" ]; then
		echo $echo_opts ":: $@" 1>&2
	fi
}

expected_params(){
	expected=$1; shift 1
	if [ ! "$#" -ge "$expected" ]; then
		warn "Bad syntax"
		exit 1
	fi
}

exit_by_invalid_cmd(){
	warn "Bad syntax" 
	build_help
	halt
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
  echo "$@" | sed 's/--\([^=]*\).*/\1/;s/-/_/g'
}

arg_value(){
  echo "$@" | sed 's/--[^=]*=\(.*\)/\1/'
}

is_arg(){
  prefix=`echo "$@" | sed 's/\(--\).*/\1/'`
  if [ "$prefix" = "--" ]; then
    echo $TRUE
  else
    echo $FALSE
  fi
}

cmd_exists(){
  type $1 2>/dev/null 1>/dev/null \
    && echo $TRUE \
    || echo $FALSE
}
