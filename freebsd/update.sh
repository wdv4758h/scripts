#!/bin/sh

update()
{
    echo "===== freebsd-update ====="
    sudo freebsd-update fetch install
    echo "===== end ====="

    echo "===== portaudoit ====="
    sudo portaudit -F
    portaudit
    echo "===== end ====="

    echo "===== portsnap ====="
    sudo portsnap fetch update
    echo "===== end ====="

    echo "===== portmaster ====="
    portmaster -L
    echo "===== end ====="
}

update | tee update.log
