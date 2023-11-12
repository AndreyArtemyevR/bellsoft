#!/bin/bash

. ./config
. ./utils/javaControl.sh
. ./utils/checker.sh

[ -z "$JAVA_HOME" ] && export "$JAVA_HOME"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

doSteps() {
    # $1 = path to the particular test case
	if [ -f "$1/config.txt" ];then
        source "$1/config.txt"
    fi
	while IFS= read -r command || [ -n "$command" ]
	do
	    cmd=$(echo "$command" | sed "s/STEP://")
		echo next step: "$cmd"
		commandOutput=$(eval "$cmd" 2>&1)
		status=$?
		echo "Command output:\n$commandOutput"
		echo "Command status: $status"
		[ "$status" -ne 0 ] && return $status
	done < $1/scenario.txt
	return 0
}

runTests() {
    # $1 = path to the tests folder
	mkdir -p "$LOGS"
	for testPath in $(ls -d $1/*)
	do
		testName=$( echo "$testPath" | awk -F '/' '{print $3}')
		[ -d "$testPath" ] && echo -n $testName || continue
		export LOG_PATH="$LOGS/$TIMESTAMP/$testName"
		mkdir -p "$LOG_PATH"
		doSteps $testPath > $LOGS/$TIMESTAMP/$testName/output.txt
		[ "$?" -eq "0" ] && echo -e ".....${GREEN}passed${NC}" || echo -e ".....${RED}failed${NC}"
	done
}

runTests ./tests
