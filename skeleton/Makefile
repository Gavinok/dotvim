######################################################################
# @author      : {{+~g:name+}} ({{+~g:email+}})
# @file        : Makefile
# @created     : {{+~strftime("%c")+}}
######################################################################

TARGET ?= a.out
SRC_DIRS ?= ./src

SRCS := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.s)
OBJS := $(addsuffix .o,$(basename $(SRCS)))
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CPPFLAGS ?= $(INC_FLAGS) -MMD -MP

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@ $(LOADLIBES) $(LDLIBS)

run:
	./$(TARGET)

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJS) $(DEPS)

-include $(DEPS)
