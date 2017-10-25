#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   computed_local_var.mk                              :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By:  <>                                        +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/23 10:58:39 by                   #+#    #+#             *#
#*   Updated: 2017/10/25 09:25:50 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

#
# Those functions are intended to compute variables which are obtained by some
# operations on the local_variables list.
# See directory_local_variables.mk

full_path_var := SRC OBJ DEP

computed_local_var :=\
	OBJ\
	DEP


# 1 : source list identifier
# 2 : suffix source
# 3 : suffix dest
# 4 : dest name identifier
# 5 : dir name
# 6 : prefix source (path)
# 7 : prefix dest (path)
define compute_list

$(info $1 $2 $3 $4 $5 $6 $7)
$4$5 := $(patsubst $6%$2,$7%$3,$($1$5))

endef

# 1 : variable name to expand
# 2 : directory name
# 3 : Identifier of the source variable (written by users)

define compute_full_path
full_path_$1$2 := $(patsubst %$($3_suffix),$2$($1_DIR$2)/%$($1_suffix),$($3$2))
endef

# 1 : directory name
define compute_full_path_var
$(foreach fp_var,$(full_path_var),$(eval $(call compute_full_path,$(fp_var),$1,SRC)))
target$1:= $1$(TARGET$1)
intermediate_target$1:= $1$(intermediate_target_prefix)$(TARGET$1)$(intermediate_target_suffix)
obj_dir$1:= $1$(OBJ_DIR$1)
dep_dir$1:= $1$(DEP_DIR$1)
src_dir$1:= $1$(SRC_DIR$1)
endef
