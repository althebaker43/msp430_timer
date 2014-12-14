#include "TimerDriver.h"

#include <stdlib.h>

typedef int Bool;
#define TRUE 1
#define FALSE 0

struct TimerInstance_struct
{
};


static Bool isDriverInitialized = FALSE;
static TimerInstance instance;


void
InitTimers()
{
    isDriverInitialized = TRUE;
}

void
TerminateTimers()
{
    isDriverInitialized = FALSE;
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

void
DestroyTimer(
        TimerInstance** timer
        )
{
    *timer = NULL;
}
