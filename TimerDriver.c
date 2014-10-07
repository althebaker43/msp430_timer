#include "TimerDriver.h"

#include <stdlib.h>

typedef int BOOL;
#define TRUE 1
#define FALSE 0

struct TimerInstance_struct
{
};


static BOOL isDriverInitialized = FALSE;
static TimerInstance instance;


void
InitTimers()
{
  isDriverInitialized = TRUE;
}

TimerInstance*
CreateTimer()
{
  if (isDriverInitialized == TRUE)
  {
    return &instance;
  }
  else
  {
    return NULL;
  }
}
