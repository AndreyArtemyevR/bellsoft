#!/bin/bash

getApplicationProcessID() {
    eval "$JAVA_HOME/jps" | grep $1 | egrep -o "^[0-9]{,5}"
}

stopJavaApp() {
    [ $(ps | grep WINPID | wc -l) -eq 0 ] && { kill $@; break; }
    for i in $@
    do
        kill $(ps | grep $i | egrep -o "[0-9]{,5}" | head -1)
    done
}

stopSameAppInstances() {
    # $1 = application name
    echo Stop existing instances of the \'$1\' application
    while true
    do
        processID=$(getApplicationProcessID $1)
        [ -z "$processID" ] && break || stopJavaApp $processID
    done
}

runJavaApplication() {
    # $1 = arguments
    # $2 = application name
	export $1
	echo "running JAVA App: $JAVA_HOME/java -classpath $PATH_TO_PROJECT/$CLASSPATH $2"
    eval "$JAVA_HOME/java -classpath $PATH_TO_PROJECT/$CLASSPATH $2"  >$LOG_PATH/output.log 2>&1 &
}

checkDeadlock() {
    # $1 = application name
    eval "$JAVA_HOME/jstack $1" > $LOG_PATH/jstack.log
	foundDeadlocks=$(egrep -ic "found [0-9]+ deadlock" $LOG_PATH/jstack.log )
	return $foundDeadlocks
}
