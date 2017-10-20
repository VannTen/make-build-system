#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   target_rule.mk                                     :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 19:15:27 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/20 13:04:26 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

#
# This file deals with the target generated by one directory.
#

intermediate_target =\
 $(intermediate_target_prefix)$(TARGET$1)$(intermediate_target_suffix)
# define a make rule for the target of the directory given as parameters
# 1 : directory_name

define define_target_rule

$(if $(TARGET$1),,$(warning No target for $1))

$(call intermediate_target,$1):$(addprefix $(OBJ_DIR$1),$(OBJ$1))
	$(QUIET) $$(static_lib)

$(TARGET$1): $(call intermediate_target,$1) $(DEPS$1)
	$(QUIET) $$(link_exec)
endef
