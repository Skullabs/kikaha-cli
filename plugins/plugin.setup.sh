#!/bin/sh
M3_BUNDLED=$WORK_DIR/mvn

setup_run(){
	setup_download_maven
	setup_update_maven_logging
	setup_save_maven_conf
  kikaha repo add project https://github.com/Skullabs/kikaha-cli-plugins.git --force=true --QUIET=true
}

setup_download_maven(){
	info "Cleaning up old temporary data..."
	rm -rf $M3_BUNDLED
	cd `tmp_dir`
	rm -rf *
	info "Downloading Maven..."
	download $M3_LATEST_VERSION latest.zip
	info "Extracting package..."
	unzip -q -x latest.zip
	cd_back
	mkdir -p $WORK_DIR
	mv `tmp_dir`/apache-maven* $M3_BUNDLED/
}

setup_update_maven_logging(){
	cd $M3_BUNDLED
	info "Updating logging..."
	rm -f lib/slf4j-simple*
	download $LOGBACK_CLASSIC lib/logback-classic.jar
	download $LOGBACK_CORE lib/logback.jar
	cd_back
}

setup_save_maven_conf(){
info "Saving maven configuration..."
cat <<EOF >> ${KDIR}/conf/setup.conf
# Auto created by 'kikaha setup'
export MAVEN_OPTS="-Dlogback.configurationFile=$MVN_LOGFILE"
export M2_HOME="$M3_BUNDLED"
export PATH="\$M2_HOME/bin:$PATH"
EOF
}
