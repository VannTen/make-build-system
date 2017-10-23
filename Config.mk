#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Config.mk                                          :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:26:46 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/23 11:26:54 by                  ###   ########.fr       *#
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
STANDARD = c99

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

# Archive maintainer flags
#
ARFLAGS = rc
ifeq ($(SYSTEM),Linux)
	ARFLAGS += -U
endif


