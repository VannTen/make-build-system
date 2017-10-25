#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   global_rules.mk                                    :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By:  <>                                        +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/25 09:40:42 by                   #+#    #+#             *#
#*   Updated: 2017/10/25 09:41:51 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# Takes one parameters, the name of a subtree

define global_rules

$(foreach GEN_DIR,obj_dir dep_dir,$(call all_of_subtree,$1,$(GEN_DIR))):
	$(QUIET) $(MKDIR) $$@
endef
