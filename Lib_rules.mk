#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Lib_rules.mk                                       :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/11/02 14:18:27 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/02 14:55:14 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

define Lib_rule_specific
$(target).$2: $(objects)
	$$(LINK_LIB)

$(target): $(target).$2

$(target).$2: include := $(compile_time_include)

$(target).$2: cflags := $(cflags)\
	$(if $(findstring $(shared_lib_suffix),$2),\
	$(shared_lib_compile_flags),$(static_lib_compile_flags))

$(objects): $(obj_dir)/%$(obj_suffix):$(src_dir)/%$(src_suffix) | $(obj_dir)
	$$(COMPILE)

endef
