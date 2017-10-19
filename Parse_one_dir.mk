#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Parse_one_dir.mk                                   :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:46:20 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 18:19:08 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# This file define a function which define the set of rules needed by one
# directory
# It takes as argument the name of the dir, which will be used as a pointer
# (aka, every variable is VARIABLE_$(DIR_NAME))

define parse_one_dir

$(eval $(call include_dir_infos,$1))

$(eval $(call define_local_variables,$1))

$(eval $(call define_target,$1))

$(eval $(call define_object,$1))

$(eval $(call collect_global_tree_variables,$1))

endef
