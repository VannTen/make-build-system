#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   computed_local_var.mk                              :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By:  <>                                        +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/23 10:58:39 by                   #+#    #+#             *#
#*   Updated: 2017/10/24 11:24:52 by                  ###   ########.fr       *#
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

define compute_full_path

$(info $1 $2 $($1$2))
full_path_$1$2 := $(addprefix $2$($1_DIR$2)/,$($1$2))

endef

define function_dummy

OBJ$1:= $(SRC$1:$(src_suffix)=$(obj_suffix))
DEP$1:= $(SRC$1:$(src_suffix)=$(dep_suffix))
endef
# 1 : directory name
define compute_full_path_var

$(eval $(call function_dummy,$1))
$(foreach fp_var,$(full_path_var),$(call compute_full_path,$(fp_var),$1))
endef
