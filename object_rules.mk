#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   object_rules.mk                                    :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/20 10:32:39 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/24 09:46:01 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

#
# This file deals with the object necessary for one target (and one directory)
# It uses static pattern rules to ensure that the rule will only be applied
# to those, not any others

define	define_object_rule


$(FINAL_OBJ$1): $1$(OBJ_DIR$1)/%$(obj_suffix): $1$(SRC_DIR$1)/%$(src_suffix)
	$(QUIET) $$(object_from_source)

endef
