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

When work is done run the following command before commiting the code;

- go fmt ./...
- go vet ./...
