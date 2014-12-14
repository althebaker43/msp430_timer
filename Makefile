PROJECT_ROOT=$(MSP430_TIMER_ROOT)

CPPUTEST_ROOT=/usr/include/CppUTest
CPPUTEST_LDFLAGS=-lCppUTest

CC=gcc
CFLAGS= \
	-g \
	-Wall \
	-Werror
C_INCLUDES=-include $(CPPUTEST_ROOT)/MemoryLeakDetectorMallocMacros.h

CCC=g++
CCFLAGS=$(CFLAGS)
CC_INCLUDES=-include $(CPPUTEST_ROOT)/MemoryLeakDetectorNewMacros.h

DRIVER_OBJS= \
	TimerDriver.o

TESTS= \
	TimerDriverBasicTest \
	TimerDriverObjectTest
TEST_OBJS=$(TESTS:%=%.o)
TEST_DRIVER=TimerDriverTester
TEST_LOG=test.log

RESIDUE= \
	$(TEST_DRIVER) \
	$(DRIVER_OBJS) \
	$(TEST_OBJS) \
	$(TEST_LOG) \
	$(FAIL_LOG)


.PHONY : all
all : tags test
	-grep -s '^.*\.cpp:[0-9]*: error' $(TEST_LOG)


.PHONY : test
test $(TEST_LOG) : $(TEST_DRIVER)
	-./$(TEST_DRIVER) > $(TEST_LOG)
	

$(TEST_DRIVER) : $(DRIVER_OBJS) $(TEST_OBJS)
	$(CCC) \
	    $(CC_INCLUDES) \
	    $(CCFLAGS) \
	    -o $@ \
	    $@.cpp $(DRIVER_OBJS) $(TEST_OBJS) \
	    $(CPPUTEST_LDFLAGS)


$(DRIVER_OBJS) : %.o : %.c %.h
	$(CC) \
	    $(C_INCLUDES) \
	    $(CCFLAGS) \
	    -c -o $@ \
	    $*.c


$(TEST_OBJS) : %.o : %.cpp %.hpp
	$(CCC) \
	    $(CC_INCLUDES) \
	    $(CCFLAGS) \
	    -c -o $@ \
	    $*.cpp

tags : $(DRIVER_OBJS:%.o=%.c) $(DRIVER_OBJS:%.o=%.h)
	ctags $^

.PHONY : clean
clean :
	rm -rf $(RESIDUE)
