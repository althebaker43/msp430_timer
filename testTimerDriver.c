#include "unity.h"

#include "TimerDriver.h"


void setUp()
{
}

void tearDown()
{
}

void test_NoTimersBeforeInit()
{
  TEST_ASSERT_NULL(CreateTimer());

  InitTimers();
  
  TEST_ASSERT_NOT_NULL(CreateTimer());
}
