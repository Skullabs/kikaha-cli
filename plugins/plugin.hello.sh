#!/bin/sh

hello_run(){
	hello_$@ || halt
}

hello_world(){
	info "Hello, $1"
	warn "Hello, $1"
	debug "Hello, $1"
}
