#.rst:
# SetProgramEnv
# ---------------
#
# Functions to set program environments.
#
# A collection of CMake utility functions for setting 
# runtime library paths, environmental variables.
#
# The following functions are provided by this module:
#
# ::
#
#    set_program_env
#
# Requires CMake 2.6 or greater because it uses function, break and
# PARENT_SCOPE.  Also depends on Powershell under windows.
#
# ::
#
#   SET_PROGRAM_ENV(<name>
#	[WORKING_DIRECTORY <dir>]
#	[RUNTIME_DIRS <dirs>...]
#	[ENVIRONMENT <VAR=value>...]
#	[COMMAND_ARGS <value>]
#	)
#
# Set runtime library paths, environmental variables and
# working directory and command arguments. See example:
#
# ::
# 
# include(SetProgramEnv)
#  
#  set_program_env(Example1
#  	WORKING_DIRECTORY
#  	"${CMAKE_BINARY_DIR}/bin"
#  	RUNTIME_DIRS
#  	"${CMAKE_BINARY_DIR}/bin"
#  	"C:\\Users\\Documents\\Visual Studio 2010"
#  	ENVIRONMENT
#  	"BINROOT=${CMAKE_BINARY_DIR}"
#  	"SRCROOT=${CMAKE_SOURCE_DIR}"
#	COMMAND_ARGS
#	"input output"
#  	)

# Author: Changjiang Yang, yangcj@gmail.com 2015
## Distributed under the BSD License: 
## http://choosealicense.com/licenses/bsd-2-clause/

set(SET_PROGRAM_ENV_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
function(set_program_env)
	include(CMakeParseArguments)
	set(options "")
	set(oneValueArgs WORKING_DIRECTORY COMMAND_ARGS)
	set(multiValueArgs RUNTIME_DIRS ENVIRONMENT)
	cmake_parse_arguments(PROGRAM_ENV "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
		
	if(MSVC)
		#Source: https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-toolset-toolsversion
		if(MSVC_VERSION GREATER_EQUAL 1910)
			# VS 2017 or greater
			set(MSBUILD_TOOLS_VERSION 15.0)
		elseif(MSVC_VERSION EQUAL 1900)
			# VS 2015
			set(MSBUILD_TOOLS_VERSION 14.0)
		elseif(MSVC_VERSION EQUAL 1800)
			# VS 2013
			set(MSBUILD_TOOLS_VERSION 12.0)
		elseif(MSVC_VERSION EQUAL 1700)
			# VS 2012
			set(MSBUILD_TOOLS_VERSION 4.0)
		elseif(MSVC_VERSION EQUAL 1600)
			# VS 2010
			set(MSBUILD_TOOLS_VERSION 4.0)
		elseif(MSVC_VERSION EQUAL 1500)
			# VS 2008
			set(MSBUILD_TOOLS_VERSION 3.5)
		elseif(MSVC_VERSION EQUAL 1400)
			# VS 2005
			set(MSBUILD_TOOLS_VERSION 2.0)
		else()
			# We don't support MSBUILD_TOOLS_VERSION for earlier compiler.
		endif()

		if("${CMAKE_GENERATOR}" MATCHES "(Win64|IA64)")
			set(comparch "x64")
		elseif("${CMAKE_SIZEOF_VOID_P}" STREQUAL "8")
			set(comparch "x64")
		else()
			set(comparch "Win32")
		endif()

		FIND_FILE(POWERSHELL NAMES powershell.exe)
		IF(POWERSHELL)
			EXECUTE_PROCESS(COMMAND "powershell" "-ExecutionPolicy" "ByPass" "-noprofile" 
				"-File" "./setvcenv.ps1"
				"-userpath" "${CMAKE_CURRENT_BINARY_DIR}/${PROGRAM_ENV_UNPARSED_ARGUMENTS}.vcxproj.user"
				"-comparch" ${comparch}
				"-conftypes" "${CMAKE_CONFIGURATION_TYPES}"
				"-workdir" "${PROGRAM_ENV_WORKING_DIRECTORY}"
				"-envars" "${PROGRAM_ENV_ENVIRONMENT}"
				"-cmdargs" "${PROGRAM_ENV_COMMAND_ARGS}"
				"-toolsversion" ${MSBUILD_TOOLS_VERSION}
				"${PROGRAM_ENV_RUNTIME_DIRS}"
				WORKING_DIRECTORY "${SET_PROGRAM_ENV_CMAKE_DIR}")
		ENDIF()
	endif()
endfunction()

