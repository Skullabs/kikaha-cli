#!/bin/sh
PLUGIN_DIR=$KDIR/plugins/

kikaha_print_title(){
  if [ ! "$QUIET" = "true" ]; then
    info "$(yellow 'kikaha') command line tool - $VERSION"
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
	if [ "`cmd_exists ${plugin_name}_run`" == "$TRUE" ]; then
		${plugin_name}_run $@
	else
		warn "Invalid command: ${plugin_nane}"
		halt
	fi
}

