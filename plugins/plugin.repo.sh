#!/bin/sh

repo_run(){
	expected_params 1 $@
	repo_$@ || repo_help
}

repo_add(){
	expected_params 2 $@
	name=$1
	url=$2

  if [ "$force" = "true" ]; then
    debug "Force mode. Removing existing data..."
    rm -rf $PLUGIN_DIR/$name
  fi

	if [ -d "$PLUGIN_DIR/$name" ]; then
		warn "Repository already exists: $(grape $name)"
		halt
	fi

	cd $PLUGIN_DIR
	info "Cloning plugin repository $name"
	git clone $url $name
	$KIKAHA $name configure $PLUGIN_DIR/$name
}

repo_update(){
	expected_params 1 $@
	cd $PLUGIN_DIR/$1
	name=$1

	info "Updating repository: $(yellow $name)"

	git pull origin master
	$KIKAHA $name configure $PLUGIN_DIR/$name
}

repo_help(){
	cd_back
}
