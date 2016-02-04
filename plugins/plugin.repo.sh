#!/bin/sh

repo_run(){
	expected_params 1 $@
	repo_$@ || repo_help
}

repo_add(){
	expected_params 2 $@
	name=$1
	url=$2

	if [ -d "$PLUGIN_DIR/$name" ]; then
		warn "Repository already exists: $(grape $name)"
		halt
	fi

	cd $PLUGIN_DIR
	info "Cloning plugin repository $name"
	git clone $url $name
	repo_enable_all_plugins_from $name
}

repo_update(){
	expected_params 1 $@
	cd $PLUGIN_DIR/$1
	name=$1

	info "Updating repository: $(yellow $name)"

	git pull origin master
	cd_back
	repo_enable_all_plugins_from $name
}

repo_enable_all_plugins_from(){
	cd $PLUGIN_DIR/$1
	files=`find . | grep './plugin.*.sh'`
	if [ ! "$files" = "" ]; then
		for plugin in plugin.*.sh; do
			plugin_name=`basename $plugin`
			ln -f -s $PLUGIN_DIR/$1/$plugin_name $PLUGIN_DIR/$plugin_name
		done
	else
		warn "No plugin found on repository $1"
	fi
}

repo_help(){
	cd_back
}
