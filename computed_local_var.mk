#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   computed_local_var.mk                              :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By:  <>                                        +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/23 10:58:39 by                   #+#    #+#             *#
#*   Updated: 2017/10/23 11:38:15 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

#
# Those functions are intended to compute variables which are obtained by some
# operations on the local_variables list.
# See directory_local_variables.mk

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

# 1 : directory name
define compute_local_var

$(info SRC of $1 = $(SRC$1))
$(eval $(call compute_list,SRC,.c,.o,OBJ,$1,$(SRC_DIR$1),$(OBJ_DIR$1)))
$(eval $(call compute_list,SRC,.c,.dep,DEP,$1,$(SRC_DIR$1),$(OBJ_DIR$1)))
$(info OBJ of $1 = $(OBJ$1))

endef
