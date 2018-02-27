#!/usr/bin/env bash
ver=$(fgrep '#define VERSION ' fqtrim.cpp)
ver=${ver#*\"}
ver=${ver%%\"*}
srcpack=fqtrim-$ver
source prep_src.sh
set +e
if [[ $(uname -m) = "x86_64" ]]; then
 binpack=$srcpack.Linux_x86_64
 echo "Linking statically on x86_64 (only works for gcc 4.5+).."
 export LDFLAGS="-static-libgcc -static-libstdc++"
fi
if [[ $(uname) = "Darwin" ]]; then
 binpack=$srcpack.OSX_x86_64
 export CFLAGS="-mmacosx-version-min=10.7"
fi
/bin/rm -rf $binpack
/bin/rm -rf $binpack.tar.gz
set -e
mkdir $binpack
cd $srcpack
# make clean
make release
mv fqtrim README LICENSE ../$binpack/
cd ..
pwd
echo "tar cvfz $binpack.tar.gz $binpack"
tar cvfz $binpack.tar.gz $binpack
echo "Update the web files:"
echo "scp $binpack.tar.gz $srcpack.tar.gz  salz1:~/html/software/fqtrim/dl/"
echo "perl -i -pe 's/fqtrim\-[\d\.]+/fqtrim-$ver./g' ~/html/software/fqtrim/index.shtml"
