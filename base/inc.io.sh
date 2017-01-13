#!/bin/sh

var_set(){
  file=$1
  var=$2
  value=$3

  sed -i -z "s/<!-- var-$var -->\([^<]*\)<!-- \/var-$var -->/<!-- var-$var -->$value<!-- \/var-$var -->/" $file
}

var_add(){
  file=$1
  var=$2
  value="$3"

  sed -i -z -e "s/<!-- var-$var -->\(.*\)<!-- \/var-$var -->/<!-- var-$var -->\1$value<!-- \/var-$var -->/g" $file
}

var_get(){
  file=$1
  var=$2

  sed -z "s/.*<!-- var-$var -->\([^<]*\)<!-- \/var-$var -->.*/\1/" $file
}
