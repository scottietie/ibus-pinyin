#! /bin/sh

CUR_PATH=$(dirname `readlink -f $0`)

file /usr/lib/ibus/ibus-engine-pinyin | grep "POSIX shell script"
if [ "$?" != "0" ]; then
    kill -9 $(pidof ibus-daemon)

    sudo mv /usr/lib/ibus/ibus-engine-pinyin /usr/lib/ibus/ibus-engine-pinyin.bin
    sudo cp $CUR_PATH/ibus-engine-pinyin /usr/lib/ibus/
    sudo cp -av sqlite_3.22/ /usr/local/lib/
fi
