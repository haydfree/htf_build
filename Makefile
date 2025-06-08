CC=					clang
LD=					clang

TARGET=				htf_build
TEST_TARGET=		run_tests
SRC_DIR=			src
INCLUDE_DIR=		include
BUILD_DIR=			build
TEST_DIR=			test

SRCS= 				$(wildcard $(SRC_DIR)/*.c)
TEST_SRCS=			$(wildcard $(TEST_DIR)/*.c)	
OBJS= 				$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRCS))
TEST_OBJS=			$(patsubst $(TEST_DIR)/%.c, $(BUILD_DIR)/test_%.o, $(TEST_SRCS))

DBFLAGS= 			-g3 -O0
CCFLAGS= 			-std=c99 -Wextra -Werror -Wpedantic -Wall $(DBFLAGS) -I. -I$(INCLUDE_DIR)
LDFLAGS=

all: $(TARGET) $(TEST_TARGET)

$(BUILD_DIR):
	@echo "-----build dir-----"
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	@echo "-----compiling $<-----"
	$(CC) $(CCFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	@echo "-----linking main program-----"
	$(CC) $(CCFLAGS) $^ -o $@

$(BUILD_DIR)/test_%.o: $(TEST_DIR)/%.c | $(BUILD_DIR)
	@echo "-----compiling test $<-----"
	$(CC) $(CCFLAGS) -c $< -o $@

$(TEST_TARGET): $(TEST_OBJS) $(filter-out $(BUILD_DIR)/main.o, $(OBJS))
	@echo "-----linking test program-----"
	$(CC) $(CCFLAGS) $^ -o $@

clean:
	@echo "-----clean-----"
	rm -rf $(BUILD_DIR) $(TARGET) $(TEST_TARGET) *.core

commit:
	@echo "-----commit-----"
	git add .
	git commit -m "AUTO COMMIT: `date +'%Y-%m-%d %H:%M:%S'`"
	git push origin main

install:
	@echo "-----install-----"
	rm -rf /usr/local/lib/$(TARGET)
	cp $(TARGET) /usr/local/lib

run: $(TARGET)
	@echo "-----running main program-----"
	./$(TARGET)

test: $(TEST_TARGET)
	@echo "-----running tests-----"
	./$(TEST_TARGET)

debug: $(TEST_TARGET)
	@echo "-----debug-----"
	lldb -o "process handle SIGTRAP -n true -s true -p true" -o "run" -- $(TEST_TARGET)

.PHONY: clean commit install all run test debug

