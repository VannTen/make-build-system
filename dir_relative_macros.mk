#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   dir_relative_macros.mk                             :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 17:20:13 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/11 16:45:15 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#


# Macros
# These macros are all relative to the the directory, which is the $1 argument
# They should be used inside a macro expanded by $call, or directly with it

target = $1$(TARGET$1)
intermediate_target = $1$(if $(findstring lib,$(TARGET$1)),,lib)$(TARGET$1).a
ext_dependencies = $(intermediate_target)\
  $(foreach sub,$(COMPONENTS$1), $(call ext_dependencies,$(sub)))
all_includes = $(INC_DIR$1) $(foreach sub,$(SUBDIRS$1),\
   $(call all_includes,$(sub)))
compile_time_include = $(foreach inc_dir, $(all_includes), -iquote$(inc_dir))

objects = $(patsubst %$(src_suffix),$(obj_dir)/%$(obj_suffix),$(SRC$1))
obj_dir = $1$(OBJ_DIR$1)
src_dir = $1$(SRC_DIR$1)

