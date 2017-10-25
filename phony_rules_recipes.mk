#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   phony_rules_recipes.mk                             :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/20 13:19:12 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/25 10:18:27 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

define	clean_targets
$(RM) $(call all_of_subtree,$(SRC_TREE_ROOT),target)
$(RM) $(call all_of_subtree,$(SRC_TREE_ROOT),intermediate_target)
endef

define clean_objects
$(RM) $(call all_of_subtree,$(SRC_TREE_ROOT),full_path_OBJ)
endef
