/* Copyright(c) 2015, Changjiang Yang yangcj@gmail.com
 All rights reserved.
 Distributed under the BSD License :
 http ://choosealicense.com/licenses/bsd-2-clause/*/

#include "gtest/gtest.h"

#include "example.h"

TEST(SampleTest, HandleZeroInput) {
	EXPECT_EQ(0, timestwo(0));
}

