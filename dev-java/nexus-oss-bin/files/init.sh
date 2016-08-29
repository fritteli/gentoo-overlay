#!/sbin/openrc-run

depend() {
    need net
    use dns logger
}

RUN_AS=nexus

checkconfig() {
    return 0
}

start() {
    checkconfig || return 1

    ebegin "Starting ${SVCNAME}"
    su $RUN_AS -c "/opt/nexus/nexus-oss-webapp/bin/nexus start"
    eend $?
}

stop() {
    ebegin "Stopping ${SVCNAME}"
    su $RUN_AS -c "/opt/nexus/nexus-oss-webapp/bin/nexus stop"
    eend $?
}
