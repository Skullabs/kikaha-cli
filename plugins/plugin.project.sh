#!/bin/sh

# VARIABLES
PROJECTS_DIR=projects

project_run(){
	expected_params 1 $@
	debug "Project Module: params: $@"
	project_$@ || halt
}

project_create(){
	template_name=$1
	name=${name:-$1}
	group_id=${group_id:-$name}
	version=${version:-1.0.0-SNAPSHOT}
	artifact_id=${artifact_id:-$name}

	debug "  Template name: $template_name"
	debug "  Name: $name"
	debug "  artifact_id: $artifact_id"

	if [ -d "$artifact_id" ]; then
		warn "A module/project named `yellow $artifact_id` already exists. Override it?"
		warn "Press ENTER to Continue, Ctrl+C to abort."
		read null
		rm -rf $artifact_id
	fi

	project__create_project_from_template \
		$template_name $artifact_id $group_id $version
}

project__create_project_from_template(){
	template_name=$1
	artifact_id=$2
	group_id=$3
	version=$4
	template_file=$KDIR/work/$PROJECTS_DIR/$template_name.tar.gz
	tmp_dir=/tmp/$$/

	if [ ! -f $template_file ]; then
		warn "No template named '$template_name' was found."
		halt
	fi

	info "Extracting template into temporary directory..." && sleep 1
	mkdir $tmp_dir -p
	cd $tmp_dir
	tar xfz $template_file || halt
	cd $template_name

	info "Configuring the project..."
	var_set pom.xml project-artifact-id $artifact_id
	var_set pom.xml project-group-id $group_id
	var_set pom.xml project-version $version
	var_set pom.xml kikaha-version `project__get_lastest_version`
	
	info "Applying changes on $CWD/$artifact_id"
	mv $tmp_dir/$template_name $CWD/$artifact_id
	info "Done."

}

project_use_last(){
	latest_version=`project__get_lastest_version`
	project_use $latest_version
}

project__get_lastest_version(){
	curl -s http://download.kikaha.io/stable-version
}

project_use(){
	expected_params 1 $@
	if [ ! -f "pom.xml" ]; then
		warn "Invalid project. No maven project found."
		info "Ensure that you choose a project folder that have a $(yellow pom.xml) file."
		debug "Current work directory: `pwd`"
		halt
	fi

	info "Setting up project to use Kikaha version $1"
	var_set pom.xml kikaha-version $1
}

project_add_dep(){
	SED_RE='\(\([^:]*\):\([^:]*\)\(:\(.*\)\)*\)'
	artifact_id=`echo $1 | sed "s/${SED_RE}/\3/"`
	group_id=`echo $1 | sed "s/${SED_RE}/\2/"`
	version=`echo $1 | sed "s/${SED_RE}/\5/"`

	if [ "$version" = "$1" ]; then
		dep=`cat <<EOF
		<dependency>
		<groupId>$group_id</groupId>
		<artifactId>$artifact_id</artifactId>
		</dependency>
		EOF
		`
	else
		dep=`cat <<EOF
		<dependency>
		<groupId>$group_id</groupId>
		<artifactId>$artifact_id</artifactId>
		<version>$version</version>
		</dependency>
		EOF
		`
	fi
	dep=$(echo $dep | sed 's/\//\\\//g')

	info "Adding $artifact_id ($group_id) at version $version as dependency"
	debug "Maven dependency :\n $dep"
	var_add pom.xml dependencies "$dep\n"
}
