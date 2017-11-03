#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Dir_rules.mk                                       :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 12:38:29 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/03 14:25:58 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

#
# This makefile part defines rules for target and object in one directory
# whose name is contained in the $1 parameter of the main function.

# Macros
# Those are for clarity for the main function, they give their precise value
# (which must include the full path from the directory make is invoked in, for 
# example).

target = $1$(TARGET$1)
intermediate_target = $1lib$(TARGET$1).a
ext_dependencies = $(intermediate_target)\
  $(foreach sub,$(COMPONENTS$1), $(call ext_dependencies,$(sub)))
all_includes = $(INC_DIR$1) $(foreach sub,$(SUBDIRS$1),\
   $(call all_includes,$(sub)))
compile_time_include = $(foreach inc_dir, $(all_includes), -iquote$(inc_dir))

objects = $(patsubst %$(src_suffix),$(obj_dir)/%$(obj_suffix),$(SRC$1))
obj_dir = $1$(OBJ_DIR$1)$2
src_dir = $1$(SRC_DIR$1)

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
LINK_EXE = $(CC) $(LDFLAGS) -o $@ $+
 
define Dir_rules
$(call $(if $(findstring lib,$(TARGET$1)),Lib_rule,Exe_rule),$1)
endef

define Exe_rule
$(target):$(ext_dependencies) $(patsubst lib%,-l%,$(LIBRARIES$1))
	$$(LINK_EXE)

$(intermediate_target):$(objects)
	$$(LINK_LIB)

$(intermediate_target): include := $(compile_time_include)

$(objects): $(obj_dir)/%$(obj_suffix):$(src_dir)/%$(src_suffix) | $(obj_dir)
	$$(COMPILE)

endef

# Rule to make libs. The variable $(TARGET$1) must be modified to allow the
# standard target all to work correctly.
#

include Lib_rules.mk
define Lib_rule
suffix_list$1:= $(suffix_list$1) $(shared_lib_suffix) $(static_lib_suffix)
$(call Lib_rule_specific,$1,$(static_lib_suffix))
$(call Lib_rule_specific,$1,$(shared_lib_suffix))
vpath $(TARGET$1).$(shared_lib_suffix) $1
vpath $(TARGET$1).$(static_lib_suffix) $1

endef
