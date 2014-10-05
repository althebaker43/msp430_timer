#include "unity.h"


void setUp()
{
}

void tearDown()
{
}

void test_FirstTest()
{
  int testVal = 1;

  TEST_ASSERT_EQUAL(2, testVal);
}

void test_SecondTest()
{
  int testVal = 1;

  TEST_ASSERT_EQUAL(1, testVal);
}

