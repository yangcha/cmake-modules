# cmake-modules
A collection of CMake utility functions for setting runtime library paths, environmental variables, working directory for Visual C++. And function for adding unit tests using google test with cmake.

```
   SET_PROGRAM_ENV(<name>
	[WORKING_DIRECTORY <dir>]
	[RUNTIME_DIRS <dirs>...]
	[ENVIRONMENT <VAR=value>...]
	)
```

The WORKING_DIRECTORY specifies the program working directory. RUNTIME_DIRS specifies the dynamic library directories. ENVIRONMENT sets the environmental variables. See the following example:

```
include(SetProgramEnv)

set_program_env( Example1
	WORKING_DIRECTORY
	"${CMAKE_BINARY_DIR}/bin"
	RUNTIME_DIRS
	"${CMAKE_BINARY_DIR}/bin"
	"C:\\Users\\Documents\\Visual Studio 2010"
	ENVIRONMENT
	"BINROOT=${CMAKE_BINARY_DIR}"
	"SRCROOT=${CMAKE_SOURCE_DIR}"
	)
```

To add an unit test with Google test, use function:
```
  ADD_GTEST(<name>
            source1 [source2 ...])
```

See the following example to add unit test using cmake with google test framework:

```
include(gtest)
add_gtest(unitTest test_example.cpp)
```
