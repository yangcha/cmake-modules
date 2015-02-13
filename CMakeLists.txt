# Copyright (c) 2015, Changjiang Yang yangcj@gmail.com
# All rights reserved.
# Distributed under the BSD License: 
# http://choosealicense.com/licenses/bsd-2-clause/

cmake_minimum_required (VERSION 2.6)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/modules")

project (Example)

include(SetProgramEnv)

add_executable(Example1 example.cxx)
set_program_env(Example1
	WORKING_DIRECTORY
	"${CMAKE_BINARY_DIR}/bin"
	RUNTIME_DIRS
	"${CMAKE_BINARY_DIR}/bin"
	"C:\\Users\\Documents\\Visual Studio 2010"
	ENVIRONMENT
	"BINROOT=${CMAKE_BINARY_DIR}"
	"SRCROOT=${CMAKE_SOURCE_DIR}"
	)

add_executable(Example2 example.cxx)
set_program_env(Example2
	WORKING_DIRECTORY
	"${CMAKE_BINARY_DIR}/bin"
	RUNTIME_DIRS
	"${CMAKE_BINARY_DIR}/bin"
	"C:\\Users\\Documents\\Visual Studio 2010"
	ENVIRONMENT
	"BINROOT=${CMAKE_BINARY_DIR}"
	"SRCROOT=${CMAKE_SOURCE_DIR}"
	)
