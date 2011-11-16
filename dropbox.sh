### BEGIN INIT INFO
# Provides:          dropbox
# Required-Start:    $local_fs $remote_fs $network $syslog $named
# Required-Stop:     $local_fs $remote_fs $network $syslog $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# X-Interactive:     false
# Short-Description: dropbox service
### END INIT INFO
# dropbox service
DROPBOX_USERS="$USER"
 
DAEMON=.dropbox-dist/dropbox
 
start() {
    echo "Starting dropbox..."
    for dbuser in $DROPBOX_USERS; do
        HOMEDIR=`getent passwd $dbuser | cut -d: -f6`
        if [ -x $HOMEDIR/$DAEMON ]; then
            HOME="$HOMEDIR" start-stop-daemon -b -o -c $dbuser -S -u $dbuser -x $HOMEDIR/$DAEMON
        fi
    done
}
 
stop() {
    echo "Stopping dropbox..."
    for dbuser in $DROPBOX_USERS; do
        HOMEDIR=`getent passwd $dbuser | cut -d: -f6`
        if [ -x $HOMEDIR/$DAEMON ]; then
            start-stop-daemon -o -c $dbuser -K -u $dbuser -x $HOMEDIR/$DAEMON
        fi
    done
}
 
status() {
    for dbuser in $DROPBOX_USERS; do
        dbpid=`pgrep -u $dbuser dropbox`
        if [ -z $dbpid ] ; then
            echo "dropboxd for USER $dbuser: not running."
        else
            echo "dropboxd for USER $dbuser: running (pid $dbpid)"
        fi
    done
}
 
case "$1" in
 
    start)
        start
        ;;
 
    stop)
        stop
        ;;
 
    restart|reload|force-reload)
        stop
        start
        ;;
 
    status)
        status
        ;;
 
    *)
        echo "Usage: /etc/init.d/dropbox {start|stop|reload|force-reload|restart|status}"
        exit 1
 
esac
 
exit 0
