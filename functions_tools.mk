#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   functions_tools.mk                                 :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 17:20:13 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/20 14:09:38 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#


define all_of
all_of_$1 = $$(foreach dir,$$(dir_list), $$($1$$(dir)))
endef

$(foreach loc_var,$(local_variables_list),$(eval $(call all_of,$(loc_var)))) 
