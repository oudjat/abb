#!/bin/bash

# Define script variables
APP_NAME="connect.sh"
PIDFILE="$APP_NAME.pid"

# Function to retrieve the PID of the process
get_pid() {
    pgrep -f "$APP_NAME"
}

# Use a case statement for different script actions
case "$1" in
    # Start section
    start)
        echo "Starting $APP_NAME ..."
        
        # Run the connect.sh script in the background
        /services/script/connect.sh > /dev/null 2>&1 &
        PID=$!  # Capture the PID of the background process
        echo $PID > $PIDFILE  # Save the PID to a file
        echo "$APP_NAME started with PID $PID."
        ;;

    status)
        # Check if the process is running and display the status
        if [ -n "$(get_pid)" ]; then
            echo "$APP_NAME is running with PID $(get_pid)."
        else
            echo "$APP_NAME is not running."
        fi
        ;;

    stop)
        echo "Stopping $APP_NAME ..."
        PID=$(get_pid)  # Get the PID from the file
        if [ -n "$PID" ]; then
            kill -TERM $PID  # Attempt to gracefully stop the process
            sleep 2
            if [ -n "$(get_pid)" ]; then
                kill -KILL $PID  # Forcefully stop the process if needed
            fi
            echo "$APP_NAME is stopping."
        else
            echo "$APP_NAME is not running."
        fi
        rm -f $PIDFILE  # Remove the PID file after stopping the process
        ;;

    restart)
        # Stop the script and then start it again
        $0 stop
        sleep 2
        $0 start
        ;;

    # Default section for invalid input
    *)
        echo "Usage $0 {status|start|stop|restart}"
        exit 1
        ;;
esac

exit 0

