#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PIDFILE=/var/run/radicale.pid

depend() {
    use net
    need localmount
}

start() {
    touch /var/log/radicale
    chown radicale:radicale /var/log/radicale
    ebegin "Starting radicale"
        start-stop-daemon --start --quiet --background \
        --user radicale \
        --pidfile ${PIDFILE} --make-pidfile \
        --exec /usr/bin/radicale -- --foreground
    eend $?
}

stop() {
    ebegin "Stopping radicale"
        start-stop-daemon --stop --quiet \
        --pidfile ${PIDFILE}
    eend $?
}
