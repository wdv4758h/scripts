#!/bin/sh

install()
{
    su

    echo 'MASTER_SITE_BACKUP?=    \
            http://freebsd.cs.nctu.edu.tw/distfiles/${DIST_SUBDIR}/
    MASTER_SITE_OVERRIDE?= ${MASTER_SITE_BACKUP}

    FORCE_MAKE_JOBS=yes
    MAKE_JOBS_NUMBER=8
    ' >> /etc/make.conf

    sed -i.bak 's/SERVERNAME=portsnap.FreeBSD/SERVERNAME=portsnap.tw.FreeBSD/' /etc/portsnap.conf

    portsnap fetch extract

    cd /usr/ports/security/sudo/
    make install clean

    sed -i.bak 's/^# %wheel ALL=(ALL) ALL$/%wheel ALL=(ALL) ALL/' /usr/local/etc/sudoers

    cd /usr/ports/ports-mgmt/portmaster/
    make install clean

}

soft_install()
{
    cat soft_freebsd | xargs sudo portmaster -dB -y -G
}

install | tee install.log
soft_install | tee soft_install.log