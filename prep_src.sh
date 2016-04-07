#!/usr/bin/env bash
ver=$(fgrep '#define VERSION ' fqtrim.cpp)
ver=${ver#*\"}
ver=${ver%%\"*}
pack=fqtrim-$ver
echo "Preparing source for $pack"
echo "--------------------------"
/bin/rm -rf $pack
/bin/rm -f $pack.tar.gz
set -e
mkdir $pack
mkdir $pack/gclib
#assuming gclib is a symlink or a subdir under current directory
#sed 's|../gclib|./gclib|' Makefile > $pack/Makefile
libdir=fqtrim-$ver/gclib/
cp Makefile LICENSE README fqtrim.cpp fqtrim-$ver/
cp ./gclib/{GVec,GList,GHash}.hh $libdir
cp ./gclib/{GAlnExtend,GArgs,GBase,gdna,GStr,GThreads}.{h,cpp} $libdir
tar cvfz $pack.tar.gz $pack
ls -l $pack.tar.gz
#scp $pack.tar.gz igm3:~/src/
