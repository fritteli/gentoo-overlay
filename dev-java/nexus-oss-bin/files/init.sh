#!/sbin/runscript

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
    su $RUN_AS -c "/opt/nexus/nexus-oss-webapp/bin/jsw/linux-x86-32/wrapper start"
    eend $?
}

stop() {
    ebegin "Stopping ${SVCNAME}"
    su $RUN_AS -c "/opt/nexus/nexus-oss-webapp/bin/jsw/linux-x86-32/wrapper stop"
    eend $?
}
