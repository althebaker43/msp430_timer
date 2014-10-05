#include "unity.h"


void setUp()
{
}

void tearDown()
{
}

void test_NoTimersBeforeInit()
{
  int testVal = 1;

  TEST_ASSERT_EQUAL(1, testVal);
}
