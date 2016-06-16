#!/bin/sh
PLUGIN_DIR=$KDIR/plugins/

kikaha_print_title(){
  if [ ! "$QUIET" = "true" ]; then
    info "$(yellow 'KIKAHA') - $(grape 'the easiest platform for writing fast microservices')"
  fi
}

kikaha_print_logo(){
if [ ! "$QUIET" = "true" ]; then
cat <<EOF
      $(yellow " __  _  ____  __  _   ____  __ __   ____ ")
      $(yellow "|  |/ ]|    ||  |/ ] /    ||  |  | /    |")
      $(yellow "|  ' /  |  | |  ' / |  o  ||  |  ||  o  |")
      $(yellow "|    \  |  | |    \ |     ||  _  ||     |")
      $(yellow "|     | |  | |     ||  _  ||  |  ||  _  |")
      $(yellow "|  .  | |  | |  .  ||  |  ||  |  ||  |  |")
      $(yellow "|__|\_||____||__|\_||__|__||__|__||__|__|")
 $(grape 'the easiest platform for writing fast microservices')

EOF
fi
}

kikaha_which_plugin(){
	plugin="$PLUGIN_DIR/plugin.${1}.sh"
	if [ -f $plugin ]; then
		echo $plugin
  else
    plugin="$PLUGIN_DIR/${1}/plugin.${1}.sh"
    if [ -f $plugin ]; then
      echo $plugin
    fi
	fi
}

kikaha_load_all_plugins(){
	for plugin in $PLUGIN_DIR/plugin.*.sh; do
		plugin_name=`echo $plugin | sed 's/plugin\.\([^\.]*\)\.sh/\1/'`
		echo $plugin_name
		. $plugin
	done
}

kikaha_run_plugin(){
	plugin_name=$1; shift
	debug "Running plugin: $(grape $plugin_name)"
	${plugin_name}_run $@
}

