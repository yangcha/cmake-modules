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

set(GTEST_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(GTEST_ROOT "${GTEST_CMAKE_DIR}/../contrib/gtest-1.7.0" CACHE PATH "Root path to the Google Test.")

if(MSVC)
	set( gtest_force_shared_crt ON CACHE BOOL "Use /MD instead of /MT for MSVC" )
endif()

add_subdirectory(${GTEST_ROOT})

#make test or ctest
enable_testing()

include_directories(SYSTEM ${GTEST_ROOT}/include)

function(add_gtest target)
	add_executable(${target} ${ARGN})
	target_link_libraries(${target} gtest gtest_main)
	add_test(${target} ${target})
endfunction()


