#!/bin/sh

var_set(){
  file=$1
  var=$2
  value=$3

  sed -i -z "s/<!-- kikaha-$var -->\([^<]*\)<!-- \/kikaha-$var -->/<!-- kikaha-$var -->$value<!-- \/kikaha-$var -->/" $file
}

var_add(){
  file=$1
  var=$2
  value="$3"

  sed -i -z -e "s/<!-- kikaha-$var -->\(.*\)<!-- \/kikaha-$var -->/<!-- kikaha-$var -->\1$value<!-- \/kikaha-$var -->/g" $file
}

var_get(){
  file=$1
  var=$2

  sed -z "s/.*<!-- kikaha-$var -->\([^<]*\)<!-- \/kikaha-$var -->.*/\1/" $file
}
