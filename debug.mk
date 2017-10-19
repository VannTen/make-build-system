#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   debug.mk                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 19:12:12 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 19:12:45 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

define print_locals
$(info For $1 :)
$(foreach loc_var,$(local_variables_list),\
	$(eval $(info $(loc_var) = $($(loc_var)$1))))
endef
