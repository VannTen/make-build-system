#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Dir_rules.mk                                       :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 12:38:29 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/14 10:13:50 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# This makefile part defines rules for target and object in one directory
# whose name is contained in the $1 parameter of the main function.

# Variable compilers flags
# Those flags are in fact macro those effective value will depend on the place
# where they are used. 

# shall be used as a target speficic variable for intermediate target, to apply
# for each of its prerequisites object files
cppflags = $(include)
compile_time_include = \
   $(foreach INC_DIR,$(INC_DIR$1) $(SUBDIRS$1),-iquote$1$(INC_DIR))

# Recipes used in the rules below

# Compilation

COMPILE = $(CC) $(cflags) $(cppflags) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

# Link

LINK_LIB = $(if $(findstring a,$(suffix $@)),\
		   $(LINK_STATIC_LIB),$(LINK_DYNAMIC_LIB))
LINK_STATIC_LIB = $(AR) $(ARFLAGS) $@ $?
LINK_DYNAMIC_LIB = $(CC) $(LDFLAGS) $(shared_flag) -o $@ $^
LINK_EXE = $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $+

# Core rules for a directory : the target, the intermediate target, and the
# objects

define Dir_rules
$(call $(if $(findstring lib,$(TARGET$1)),Lib_rule,Exe_rule),$1)
endef

define Exe_rule
$(target):$(ext_dependencies) $(patsubst lib%,-l%,$(LIBRARIES$1))
	$$(LINK_EXE)

$(intermediate_target):$(objects)
	$$(LINK_LIB)

$(objects): include := $(compile_time_include)

$(objects): $(obj_dir)/%$(obj_suffix):$(src_dir)/%$(src_suffix) | $(obj_dir)
	$$(COMPILE)

endef

# Rule to make libs. The variable $(TARGET$1) must be modified to allow the
# standard target all to work correctly.
#

