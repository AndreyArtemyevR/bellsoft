#!/bin/bash

. ./utils/javaControl.sh

checkDeadlockNotHappened() {
    # $1 = application name to work with
	echo Checking app \'$1\'
	while true 
    do
        sleep 1
		processID=$(getApplicationProcessID $1)
		[ -z "$processID" ] && break
		checkDeadlock $1
		[ "$?" -ne 0 ] && { RESULT="test failed: deadlock occurred"; stopJavaApp $processID; return 1; }
    done
	RESULT="test passed"
	return 0
}