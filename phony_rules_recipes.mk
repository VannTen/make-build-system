#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   phony_rules_recipes.mk                             :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/20 13:19:12 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/20 14:07:13 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

define	clean_targets
$(RM) $(all_of_TARGET)
$(RM) $(foreach dir,$(dir_list), $(call intermediate_target,$(dir)))
endef

define clean_objects
$(RM) $(foreach dir,$(dir_list), $(OBJ$(dir)))
endef
