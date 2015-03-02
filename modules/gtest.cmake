#.rst:
# gtest
# -----
#
# Functions to set gtest.
#
# ::
# 
#  ADD_GTEST(<name>
#            source1 [source2 ...])
#
# See example:
# ::
# 	include(gtest)
#	add_gtest(unitTest test_example.cpp)

# Copyright (c) 2015, Changjiang Yang yangcj@gmail.com
# All rights reserved.
# Distributed under the BSD License: 
# http://choosealicense.com/licenses/bsd-2-clause/

set(GTEST_ROOT "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "Root path to the Google Test.")

# where will executable tests be written ?
IF (EXECUTABLE_OUTPUT_PATH)
    SET (CXX_TEST_PATH ${EXECUTABLE_OUTPUT_PATH})
ELSE ()
    SET (CXX_TEST_PATH .)
ENDIF()

#make test or ctest
enable_testing()

include_directories(SYSTEM ${GTEST_ROOT})

function(add_gtest target)
	add_definitions(-DGTEST_HAS_PTHREAD=0)
	add_executable(${target} ${ARGN}
		${GTEST_ROOT}/gtest_main.cc
		${GTEST_ROOT}/gtest/gtest-all.cc
		)
	add_test(${target} ${CXX_TEST_PATH}/${target})
endfunction()


