#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   computed_local_var.mk                              :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By:  <>                                        +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/23 10:58:39 by                   #+#    #+#             *#
#*   Updated: 2017/10/23 11:21:24 by                  ###   ########.fr       *#
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

$4$5 := $(patsubst $6%$2,$6%$3,$1$5)

endef

# 1 : directory name
define compute_local_var

$(call compute_list,SRC,.c,.o,OBJ,$(SRC_DIR$1),$(OBJ_DIR$1))
$(call compute_list,SRC,.c,.dep,DEP,$(SRC_DIR$1),$(OBJ_DIR$1))

endef
