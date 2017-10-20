#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   target_recipes.mk                                  :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/20 11:29:13 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/20 15:36:20 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

##
## This file is used to define the recipes for various type of targets
##

define static_lib
$(if $(PRINT_INFO),$(info Archiving in static library $@ ...))
$(AR) $(ARFLAGS) $@ $?
$(RANLIB) $@
endef

define link_exec
$(if $(PRINT_INFO),$(info Linking $@ ...))
$(LD) $(ldflags) $(LDFLAGS) $(LD_DEST_OPT) $@ $+
endef

define	object_from_source
$(if $(PRINT_INFO),$(info Compiling $@ ...))
$(CC) $(cflags) $(cppflags) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
endef

define	obj_dep_form_source
$(CC) $(depflags) $(DEPFLAGS) 
$(POST_PROCESS_DEP)
endef
