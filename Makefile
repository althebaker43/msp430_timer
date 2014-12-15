PROJECT_ROOT=$(MSP430_TIMER_ROOT)

CPPUTEST_ROOT=/usr/include/CppUTest
CPPUTEST_LDFLAGS=-lCppUTest

CC=gcc
CFLAGS= \
	-g \
	-Wall \
	-Werror
C_INCLUDES= \
	-include $(CPPUTEST_ROOT)/MemoryLeakDetectorMallocMacros.h \
	-Imocks

CCC=g++
CCFLAGS=$(CFLAGS)
CC_INCLUDES= \
	-include $(CPPUTEST_ROOT)/MemoryLeakDetectorNewMacros.h \
	-Imocks

DRIVER_OBJS= \
	TimerDriver.o

MOCK_MCU_DIR=$(PROJECT_ROOT)/mocks
MOCK_MCU_OBJ= $(MOCK_MCU_DIR)/msp430f5529.o

TESTS= \
	TimerDriverBasicTest \
	TimerDriverObjectTest \
	TimerDriverRunTest
TEST_OBJS=$(TESTS:%=%.o)
TEST_DRIVER=TimerDriverTester
TEST_LOG=test.log

RESIDUE= \
	$(TEST_DRIVER) \
	$(DRIVER_OBJS) \
	$(MOCK_MCU_OBJ) \
	$(TEST_OBJS) \
	$(TEST_LOG) \
	$(FAIL_LOG)


.PHONY : all
all : tags test
	-grep -s '^.*\.cpp:[0-9]*: error' $(TEST_LOG)


.PHONY : test
test $(TEST_LOG) : $(TEST_DRIVER)
	-./$(TEST_DRIVER) > $(TEST_LOG)
	

$(TEST_DRIVER) : $(DRIVER_OBJS) $(MOCK_MCU_OBJ) $(TEST_OBJS)
	$(CCC) \
	    $(CC_INCLUDES) \
	    $(CCFLAGS) \
	    -o $@ \
	    $@.cpp $(DRIVER_OBJS) $(MOCK_MCU_OBJ) $(TEST_OBJS) \
	    $(CPPUTEST_LDFLAGS)


$(DRIVER_OBJS) $(MOCK_MCU_OBJ) : %.o : %.c %.h
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
