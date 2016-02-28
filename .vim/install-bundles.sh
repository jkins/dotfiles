#!/usr/bin/env bash

BUNDLE_DIR=~/.vim/bundle

mkdir -p $BUNDLE_DIR
cd $BUNDLE_DIR

while read url; do
  # get name from http://path/to/name.git
  tmp=${url##*/}
  name=${tmp%.git}

  # update existing bundles, otherwise install
  if [ -d ./$name ]; then
    echo "Updating $name"
    pushd ./$name > /dev/null
    git pull
    popd > /dev/null
  else
    echo "Installing $name"
    git clone $url
  fi

done < ../pathogen-bundles.txt

