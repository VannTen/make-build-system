#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2016/11/04 13:12:11 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 16:26:33 by mgautier         ###   ########.fr       *#
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

DEBUG_TEST_INVOK :=\
	$(DEBUGGER) --source <( echo -e "br set --name main\nrun\nnext" ) --
##
## Project specific variable
##

# Extern variables (depending on build environnement)


##
## Externals programms flags
##


# Linker flags

##
## Build tools
##

# Object file compilation and dependency generation
# (as a side effect, see DEPFLAGS)

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




##
## Collecting variables (filled during the parsing of Rules.mk and sub-Rules.mk)
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

##
## Inclusion of subdirectories Makefiles (Rules.mk)
##

include Rules.mk

# Include all dependency files collected from sub makfiles

-include $(DEP_FILES)

# After having included all sub-Rules.mk, define the rules
# to create new directories if needed.
# (the directories are order-only prerequisites on build rules)

$(GENERATED_SUBDIRS):
	+$(MKDIR) $@


# This is for be sure that the top level directory reecipes do not count
# on the last value of DIR (the directory from where make is invoked)

DIR := THIS_IS_A_BUG	

$(info End of Makefile parsing)
