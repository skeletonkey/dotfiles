# Go Lang Rules for Cline

## Version Management

gvm is used to manage the versions of Go

Do NOT install new versions!

If the codebase requires a version that is not currently available inform the user and wait until the issue is addressed.

Do not change the version of Go for the project without explicit instructions. If explicit instruction have not be provided inform the operator of the need for a different version and ask for instructions.

## Version Control

Git is used for version control. Only source code files should be committed.

The build of a project should NOT be committed. If a file appears to be binary ask the operator before checking it in or altering it.

## Formatting

When work is done run the following command before committing the code;

- go mod tidy
- go fmt ./...
- go vet ./...
- go test ./...

## Testing

All new functionality should be tested and all test should pass before committing it.

A good habit is to run all the tests with code coverage before and after you've written the code. The coverage percentage should not go down from before to after. It should stay the same or increase. If code coverage drops and it is an expected drop advice the operator and ask for instructions.

## Import Formatting

Import sections of a file should follow this format when possible:

- Go core modules
- external modules
- internal modules

Each type of module should be grouped together, sorted on the module name (not the import alias), and have spaces around each grouping.

The use of new modules needs to be carefully considered. If it is not a core Go module, the operator needs to be informed what what module you want to use and why. The operator may provide a different module to accomplish the task. Review the module suggested and provide feedback if the module does not fit your use case or may present security issues.

## Documentation

Each new function/method needs to be documented. The documentation should give a brief explanation of what the function/method does. Any unusual patterns or assumptions should be mentioned, but you should keep these descriptions short. IDEs display the function/method's contract, hence, describing inputs and outputs are only necessary if there are assumptions about the inputs/outputs that are not obvious.
