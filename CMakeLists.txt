# Copyright (c) 2015, Changjiang Yang yangcj@gmail.com
# All rights reserved.
# Distributed under the BSD License: 
# http://choosealicense.com/licenses/bsd-2-clause/

cmake_minimum_required (VERSION 2.6)

option(build_tests "Build all of tests." OFF)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/modules")

find_package(Git)
if(GIT_FOUND)
  message("git found: ${GIT_EXECUTABLE}")
  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
	  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                  OUTPUT_VARIABLE gitrev
                  ERROR_QUIET
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
  message("git repository revision: ${gitrev}")
endif()

project (Example)

include(SetProgramEnv)

add_definitions(-DGITVERSION="${gitrev}")

add_executable(Example1 example.cxx)
set_program_env(Example1
	WORKING_DIRECTORY
	"${CMAKE_BINARY_DIR}"
	RUNTIME_DIRS
	"${CMAKE_BINARY_DIR}"
	"C:\\Users\\Documents\\Visual Studio 2010"
	ENVIRONMENT
	"BINROOT=${CMAKE_BINARY_DIR}"
	"SRCROOT=${CMAKE_SOURCE_DIR}"
	)

add_executable(Example2 example.cxx)
set_program_env(Example2
	WORKING_DIRECTORY
	"${CMAKE_BINARY_DIR}"
	RUNTIME_DIRS
	"${CMAKE_BINARY_DIR}"
	"C:\\Users\\Documents\\Visual Studio 2010"
	ENVIRONMENT
	"BINROOT=${CMAKE_BINARY_DIR}"
	"SRCROOT=${CMAKE_SOURCE_DIR}"
	)

if (build_tests)
	include(gtest)
	add_gtest(unitTest test_example.cpp)
endif()
