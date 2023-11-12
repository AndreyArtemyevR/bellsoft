*Script is intended to run tests.

*Tests are stored at 'tests' folder:
- each test is a folder
- each folder should contain 'scenario.txt' file
-- file contains steps that should be executed during the test.
-- either pre-existing/own commands or shell commands/scripts (in theory, not checked) could be used.
-- pre-existing commands are available at 'utils/javaControl.sh' and 'utils/checker.sh'. Same places could be used for adding new/own commands.
-- syntax: 'STEP: <command>'
-- it is allowed to use system/environment variable in commands
- each folder may contain 'config.txt' file (there is no check yet on the file existence)
-- file contains variables that should be set in order to make test work correctly.

*Logs are stored at $LOGS/<test run timestamp>/<test name>. Available logs:
- output.txt: log file with test steps output, executed during the test run.
- output.log: log file of the Java application. Will require to use generic name for the file in the future to allow launch multiple applications per test case.

*Configuration
Using the file 'config',
- Configure JAVA_HOME variable to point it to the desired JRE/bin folder
- Specify log folder to store tests (can re-use existing value)
- Specify folder with projects using PATH_TO_PROJECT variable
-- e.g. if the project stored at /home/rocky8/IntelliJ/MyProject , then PATH_TO_PROJECT variable should be '/home/rocky8/IntelliJ/'
-- all projects should be stored at the same place, e.g. /home/rocky8/IntelliJ/

*Start
- Open command line interface - either shell or its analogue (e.g. gitbash)
- Navigate to the test system folder
- Run tests:
-- ./start.sh

*Notes
Scripts have been tested with some limitation. Please, take it into account before running tests:
- a single Java application was checked
- scripts are using relative paths, you should run it only inside the test system folder
- using shell commands or scripts is experimental feature and may lead to unpredictable behavior
- there is no ability to launch specific bunch of tests yet
