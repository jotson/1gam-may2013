#!/bin/sh

ROOT=/home/john/code/OneGameAMonth/2013/04-mar
RELEASE=$ROOT/release
JS=$ROOT/js
NME=$ROOT/nme
WWW=/var/www/flagrantdisregard.com/
VERSION=`git log --oneline | head -1 | awk '{ print $1 }'`
DEBUG='-debug'

if [ -n "$1" ]; then
    MODE="$1"
else
    MODE="flash"
fi


if [ "$MODE" = "flash" ]; then
    echo "Building Flash target"
    nme test $NME/project.nmml flash $DEBUG
fi

if [ "$MODE" = "linux" ]; then
    echo "Building Linux target"
    nme test $NME/project.nmml linux $DEBUG
fi

if [ "$MODE" = "android" ]; then
    echo "Building Android target"
    nme test $NME/project.nmml android $DEBUG
fi

if [ "$MODE" = "release" ]; then
    echo "Building HTML"
    if [ -e $RELEASE ]; then
        rm -r $RELEASE
    fi
    mkdir -p $RELEASE
    sed "s/{VERSION}/$VERSION/g" $ROOT/index.html >$RELEASE/index.html
    rsync -az --exclude=index.html $ROOT/js/ $RELEASE/

    echo "Building Flash target"
    nme build $NME/project.nmml flash $DEBUG >/dev/null
    cp $NME/build/flash/bin/*.swf $RELEASE

    echo "Building Android target"
    nme build $NME/project.nmml android $DEBUG >/dev/null
    cp $NME/build/android/bin/bin/*-debug.apk $RELEASE

    echo "Copying HTML build to web root"
    rsync -az --delete $RELEASE/ $WWW

    SIZE=`du -sh $RELEASE/*.swf | awk '{ print $1 }'`
    echo "Flash file size: $SIZE"

    SIZE=`du -sh $RELEASE/*.apk | awk '{ print $1 }'`
    echo "Android file size: $SIZE"
fi

echo "Done"
