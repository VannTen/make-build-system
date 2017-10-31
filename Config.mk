#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Config.mk                                          :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:26:46 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/31 17:57:56 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

SHELL = /bin/bash
DEBUGGER := lldb
CC := gcc
AR := ar
LD := ld
MKDIR := mkdir
RMDIR := rm -Rf
SED := sed
LN := ln -f
TOUCH := touch
RANLIB := ranlib

FILE_CHAR_RANGE := a-z0-9._
STANDARD = c11

SYSTEM = $(shell uname)

# Compiler flags
ERROR_FLAGS := -Wall -Wextra -Werror -std=$(STANDARD) -pedantic-errors
DEBUG_FLAGS := -g3 -fsanitize=undefined -fsanitize=address -fno-omit-frame-pointer
SYNTAX_FLAGS := -fsyntax-only -ferror-limit=0
OPTI_CFLAGS := -flto -Ofast
OPTI_LDFLAGS := -flto
PROFILE_FLAGS :=
CFLAGS := $(CFLAGS) $(ERROR_FLAGS)
ARFLAGS :=

# Variable compilers flags
# Those flags are in fact macro those effective value will depend on the place
# where they are used. 

# shall be used as a target speficic variable for intermediate target, to apply
# for each of its prerequisites object files
cppflags = $(include)
compile_time_include = $(foreach INC_DIR,$(INC_DIR$1) $(SUBDIRS$1),-iquote$1$(INC_DIR))
# Archive maintainer flags
#
ARFLAGS = rc
ifeq ($(SYSTEM),Linux)
	ARFLAGS += -U
endif


# Language settings
#
obj_suffix := .o
src_suffix := .c
