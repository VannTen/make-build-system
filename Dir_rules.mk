#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Dir_rules.mk                                       :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 12:38:29 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/31 13:02:16 by mgautier         ###   ########.fr       *#
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
ext_dependencies = $(intermediate_target) $(foreach sub,$(SUBDIRS$1),\
				   $(call ext_dependencies,sub))
all_includes = $(INC_DIR$1) $(foreach sub,$(SUBDIRS$1),\
				   $(call all_includes,sub))
compile_time_include = $(foreach inc_dir, $(all_includes), -iquote$(inc_dir))
objects = $(patsubst %$(src_suffix),$(obj_dir)%$(obj_suffix),$(SRC$1))
obj_dir = $1$(OBJ_DIR$1)
src_dir = $1$(SRC_DIR$1)

 
define Dir_rules

$(target):$(intermediate_target) $(ext_dependencies)
	$(LINK_EXE)

$(intermediate_target):$(objects)
	$(ARCHIVE_LIB)

$(intermediate_target): include := $(compile_time_include)

$(objects): $(obj_dir)%$(obj_suffix):$(src_dir)%$(src_suffix) | $(obj_dir)
	$(COMPILE)

endef
