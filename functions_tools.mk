#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   functions_tools.mk                                 :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 17:20:13 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/23 12:05:47 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#


define all_of
all_of_$1 = $$(foreach dir,$$(dir_list), $$($1$$(dir)))
endef

$(foreach loc_var,$(local_variables_list),$(eval $(call all_of,$(loc_var)))) 

define add_slash_to_path

endef
