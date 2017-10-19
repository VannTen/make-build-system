#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2016/11/04 13:12:11 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 14:50:39 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

$(info Begin Makefile parsing...)
##
## Variable stuff
##

DEFAULT_RULE := debug
QUIET := @
PRINT_INFO := KK
#ifeq ($(MAKECMDGOALS),debug)
#BUILD_PREFIX := debug
#endif
#ifeq ($(MAKECMDGOALS),dclean)
#BUILD_PREFIX := debug
#endif
#ifeq ($(DEFAULT_RULE),debug)
#BUILD_PREFIX := debug
#endif

##
## Externals programms
##

SHELL = /bin/bash
DEBUGGER := lldb
DEBUG_TEST_INVOK :=\
	$(DEBUGGER) --source <( echo -e "br set --name main\nrun\nnext" ) --
CC := gcc
AR := ar
MKDIR := mkdir
RMDIR := rm -Rf
SED := sed
LN := ln -f
TOUCH := touch
RANLIB := ranlib

##
## Project specific variable
##

FILE_CHAR_RANGE := a-z0-9._
STANDARD = -std=c99

# Extern variables (depending on build environnement)

SYSTEM = $(shell uname)

##
## Externals programms flags
##

# Compiler flags
ERROR_FLAGS := -Wall -Wextra -Werror $(STANDARD) -pedantic-errors
DEBUG_FLAGS := -g3 -fsanitize=undefined -fsanitize=address -fno-omit-frame-pointer
SYNTAX_FLAGS := -fsyntax-only -ferror-limit=0
OPTI_CFLAGS := -flto -Ofast
OPTI_LDFLAGS := -flto
PROFILE_FLAGS :=
CFLAGS := $(CFLAGS) $(ERROR_FLAGS)

CPPFLAGS += $(foreach INC,$(INCLUDE),-iquote$(INC))\
			$(foreach INC_LIB,$(LIB_INCLUDES),-iquote$(INC_LIB))
DEPFLAGS = -MT $@ -MP -MMD -MF $(word 2,$^).tmp

# Linker flags

# Archive maintainer flags
ARFLAGS = rc
ifeq ($(SYSTEM),Linux)
	ARFLAGS += -U
endif

##
## Build tools
##

# Object file compilation and dependency generation
# (as a side effect, see DEPFLAGS)
COMPILE = $(CC) $(DEPFLAGS) $(OPTI_FLAGS) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

# Post processing on depencency file (done after compilation) for relative path.
POSTCOMPILE = $(SED)\
  -e 's|$(OBJ_LOCAL_$(DIR))\([$(FILE_CHAR_RANGE)]*\.o\)|$$(OBJ_LOCAL_$(DIR))\1|g'\
  -e 's|$(SRC_LOCAL_$(DIR))\([$(FILE_CHAR_RANGE)]*\.c\)|$$(SRC_LOCAL_$(DIR))\1|g'\
  -e 's|$(INC_LOCAL_$(DIR))\([$(FILE_CHAR_RANGE)]*\.h\)|$$(INC_LOCAL_$(DIR))\1|g'\
  $(foreach LIB,$($(DIR)_LIBS),-e \
 's|$($(LIB)_PATH)\([$(FILE_CHAR_RANGE)]*\.h\)|$$($(LIB)_PATH)\1|g')\
  $(word 2,$^).tmp > $(word 2,$^)

# Add objects files to archive (static library)
define LINK_STATIC_LIB
$(if $(PRINT_INFO),$(info Archiving in static library $@ ...))
$(QUIET)$(AR) $(ARFLAGS) $@ $?
$(QUIET)$(RANLIB) $@
endef
# Linker
define LINK_EXE
$(if $(PRINT_INFO),$(info Linking $@ ...))
$(QUIET)$(CC) $(LDFLAGS) $(LD_OPTI_FLAGS) $^ -o $@ $(LDFLAGS_TGT)
endef


INTERMEDIATE_TARGET = lib$(TARGET_$(DIR)).a

##
## Macro variables
##

# These variables are used to obtain the .o and .dep files list
# for each level of the projet, by using the current value of SRC.

OBJ = $(patsubst %.c,$(OBJ_LOCAL_$(DIR))%.o,$(SRC))
DEP = $(patsubst %.c,$(DEP_LOCAL_$(DIR))%.dep,$(SRC))

# Functions for handling directories and inclusion of submakefiles

define INCLUDE_SUBDIRS
include $(DIR)$(SUBDIR)Rules.mk
endef

define TARGET_ERROR
$$(error $$(DIR) : No target if indicated for that directory))
endef

define ADD_SLASH
$1_LOCAL_$(DIR) := $(if $($1_DIR),$(DIR)$($1_DIR)/,$(DIR))
endef

# Assure a clean state before computing rules in a subdir
EMPTY_SRCS.MK := TARGET \
	SRC \
	SRC_DIR \
	INC_DIR \
	OBJ_DIR \
	DEP_DIR \
	TEST_DIR \
	SUBDIRS 
EMPTY_DEPS.MK := LIBRARY ELSE OBJECTS SUBDIRS SYSTEM_LIBRARY
CLEAR_VAR_LIST = $(foreach VARIABLE, $1,$(eval $(VARIABLE):= )) 


##
## Build rules
##

# Compilation rule for objects files (.o) from C source files (.c)
# Generate dependencies files (.dep) as a side effet
# That macro is used with eval in each subdirs to generate a static pattern rule
# for the objects files in that directory

%.o: %.c

define	STATIC_OBJ_RULE
$(OBJ_$(DIR)): $(OBJ_LOCAL_$(DIR))%.o: $(SRC_LOCAL_$(DIR))%.c\
$(DEP_LOCAL_$(DIR))%.dep | $(OBJ_LOCAL_$(DIR)) $(DEP_LOCAL_$(DIR))
	$(if $(PRINT_INFO), $$(info Compiling $$@ ...))
	$$(QUIET) $$(COMPILE)
	$$(QUIET) $$(POSTCOMPILE)
	$$(QUIET) $(RM) $$(word 2,$$^).tmp
	$$(QUIET) $(TOUCH) $$@
endef

%.dep: ;

##
## Testing 
##

UNIT_TESTS = $(patsubst %.c, $(DIR)test_bin/%, $(SRC_$(DIR)))
define UNIT_TEST_RULE
$(UNIT_TESTS): $(DIR)test_bin/%: $(INTERMEDIATE_TARGET) $(LIB_TEST)\
	$$(patsubst lib%,-l$$(BUILD_PREFIX)%,$$(LIBS_$$(DIR)))\
	| $(DIR)test_bin/
	$$(LINK_TEST) 
	$(QUIET)$(CC) -xc\
	<(echo -e "int main(void){return (test_$$(notdir $$@)());}")\
	$(CFLAGS) $$(CPPFLAGS) $(LDFLAGS) $(LD_OPTI_FLAGS)\
	$$^

$(addsuffix .latest_test, $(UNIT_TESTS)): %.latest_test: %
	$$(QUIET)echo Testing $$(subst test_bin/,,$$<).c ...
	$$(QUIET)./$$< || ( echo "Error on $$<, invoking $$(DEBUGGER)";\
		$$(DEBUG_TEST_INVOK) ./$$< && exit 1 )
	$$(QUIET)touch $$@
	$$(QUIET)echo $$(subst test_bin/,,$$<).c : check !

GENERATED_SUBDIRS += $(DIR)test_bin/
endef

define TEST_RULE
$(DIR)_test: $(addsuffix .latest_test, $(UNIT_TESTS))

ALL_TESTS := $(ALL_TESTS) $(DIR)_test
endef


.PRECIOUS: %.dep


##
## Collecting variables (filled during the parsing of Rules.mk and sub-Rules.mk)
##

# These three variables collect respectively : 
# all object files, target files and dependencies files, 
# and submakefiles (that can be generated).

CLEAN :=
FCLEAN :=
MKCLEAN :=

# Initializes as simple variables collector for, respectively,
# library path (used for compilation rules)
# directories that may not exist at build time and are required 
# (objects directories and dependencies directories)
# and dependencies files.

LIBPATH_INC :=
GENERATED_SUBDIRS :=
DEP_FILES :=

##
## Inclusion of subdirectories Makefiles (Rules.mk)
##

# Initialize the DIR variable, which tracks the directory 
# whose make is parsing the Rules.mk
# One option could be to initializes it with the value of 
# $(CURDIR) or $(shell pwd), to get the absolute path.
# However, that could cause trouble to produce a separate build tree.

DIR := 

# Includes the local Rules.mk, 
# which will include all the subdirectories Rules.mk
# (It could eventually include itself, since the DIR variable is independant
# from the actual location # of Rules.mk ; to think about)

include Rules.mk

# Include all dependency files collected from sub makfiles

-include $(DEP_FILES)

# After having included all sub-Rules.mk, define the rules
# to create new directories if needed.
# (the directories are order-only prerequisites on build rules)

$(GENERATED_SUBDIRS):
	+$(MKDIR) $@

##
## Standard rules for users
##

# $(TARGET_$(DIR) will expand in $(TARGET_), since DIR will recover 
# its initial value and the end of the parsing of the Rules.mk files
# (see the standard entry and exit gates on Rules.mk)

# Because the Norm said so.................

NAME = ___name___
all: $(DEFAULT_RULE)

test: $(ALL_TESTS)

opti: $(NAME)

$(NAME): $(TARGET_$(DIR)) test

# Make sure the default target is always all
.DEFAULT_GOAL:= all

clean:
	$(QUIET)$(RM) $(CLEAN)

mkclean:
	$(QUIET)$(RM) $(MKCLEAN)

fclean: clean
	$(QUIET)$(RM) $(FCLEAN)

dclean: fclean

dirclean:
	$(QUIET)$(RMDIR) $(GENERATED_SUBDIRS)

mrproper: fclean mkclean

re: fclean all

debug: $(NAME)

profile: $(NAME)

syn: $(NAME)

syn: CFLAGS := $(CFLAGS) $(SYNTAX_FLAGS)
syn: QUIET := @
syn: LDFLAGS := $(LDFLAGS) $(SYNTAX_FLAGS)
debug: CFLAGS := $(CFLAGS) $(DEBUG_FLAGS)
debug: LDFLAGS := $(LDFLAGS) $(DEBUG_FLAGS)
opti: CFLAGS := $(CFLAGS) $(OPTI_CFLAGS)
opti: LDFLAGS := $(LDFLAGS) $(OPTI_LDFLAGS)
profile: CFLAGS := $(CFLAGS) $(PROFILE_FLAGS)
profile: LDFLAGS := $(LDFLAGS) $(PROFILE_FLAGS)
.PHONY: $(NAME) debug all clean fclean mkclean dirclean re test $(ALL_TESTS)

# This is for be sure that the top level directory reecipes do not count
# on the last value of DIR (the directory from where make is invoked)

DIR := THIS_IS_A_BUG	

$(info End of Makefile parsing)
