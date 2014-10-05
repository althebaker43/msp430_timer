PROJECT_ROOT=$(MSP430_TIMER_ROOT)

CC=gcc
CFLAGS= \
	-g \
	-Wall \
	-Werror

UNITY_OBJ=unity.o
UNITY_CFLAGS= \
	$(CFLAGS) \
	-DTEST \
	-DUNITY_SUPPORT_64

TEST_SRC=testTimerDriver.c
TEST_OBJ=testTimerDriver.o

DRIVER_SRC=TimerDriver.c
DRIVER_OBJ=TimerDriver.o

RUNNER_SRC=testRunnerTimerDriver.c
RUNNER_GEN_RUBY=$(UNITY_ROOT)/auto/generate_test_runner.rb

TEST_EXE=testTimerDriver

TEST_LOG=test.log

INCLUDE_DIRS= \
	$(UNITY_ROOT)/src

RESIDUE= \
	$(UNITY_OBJ) \
	$(TEST_OBJ) \
	$(DRIVER_OBJ) \
	$(RUNNER_SRC) \
	$(TEST_EXE) \
	$(TEST_LOG)


.PHONY : all
all : test

.PHONY : test
test : $(TEST_EXE)
	./$(TEST_EXE) | tee $(TEST_LOG)
	
$(TEST_EXE) : $(RUNNER_SRC) $(UNITY_OBJ) $(TEST_OBJ) $(DRIVER_OBJ)
	$(CC) \
	  $(INCLUDE_DIRS:%=-I%) \
	  $(CFLAGS) \
	  -o $@ \
	  $^

$(DRIVER_OBJ) : $(DRIVER_SRC)
	$(CC) \
	  $(INCLUDE_DIRS:%=-I%) \
	  $(CFLAGS) \
	  -c -o $@ \
	  $(DRIVER_SRC)

$(RUNNER_SRC) : $(TEST_SRC)
	ruby $(RUNNER_GEN_RUBY) \
	  $(TEST_SRC) \
	  $@

$(TEST_OBJ) : $(TEST_SRC)
	$(CC) \
	  $(INCLUDE_DIRS:%=-I%) \
	  $(CFLAGS) \
	  -c -o $@ \
	  $(TEST_SRC)

$(UNITY_OBJ) : $(UNITY_ROOT)/src/unity.c
	$(CC) \
	  $(INCLUDE_DIRS:%=-I%) \
	  $(UNITY_CFLAGS) \
	  -c -o $@ \
	  $(UNITY_ROOT)/src/unity.c

.PHONY : clean
clean :
	rm -rf $(RESIDUE)
