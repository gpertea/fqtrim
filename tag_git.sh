#!/bin/bash -e
ver=$(fgrep '#define VERSION ' fqtrim.cpp)
ver=${ver#*\"}
ver=${ver%%\"*}
git checkout master
git tag -a "v$ver" -m "release $ver"
git push --tags
