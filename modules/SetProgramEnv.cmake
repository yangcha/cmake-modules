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
#	)
#
# Set runtime library paths, environmental variables

# Copyright (c) 2015, Changjiang Yang yangcj@gmail.com
# All rights reserved.
# Distributed under the BSD License: 
# http://choosealicense.com/licenses/bsd-2-clause/

set(SET_PROGRAM_ENV_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
function(set_program_env)
	set(options "")
	set(oneValueArgs WORKING_DIRECTORY)
	set(multiValueArgs RUNTIME_DIRS ENVIRONMENT)
	cmake_parse_arguments(PROGRAM_ENV "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
	if(WIN32)
		FIND_FILE(POWERSHELL NAMES powershell.exe)
		IF(POWERSHELL)
			EXECUTE_PROCESS(COMMAND "powershell" "-ExecutionPolicy" "ByPass" "-noprofile" 
				"-File" "./setvcenv.ps1" 
				"${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.vcxproj.user"
				"${PROGRAM_ENV_RUNTIME_DIRS}"
				WORKING_DIRECTORY ${SET_PROGRAM_ENV_CMAKE_DIR})
		ENDIF()
	endif()
endfunction()

