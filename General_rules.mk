#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   General_rules.mk                                   :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/11/03 14:30:29 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/03 14:33:26 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# This file defines rules used across all the source tree, after it has been
# parsed. For example, it defines directory generation rules.

# Function to collect directory names accross the source tree,
# if they exist (if they dont, objects or deps or whatever else
# are simply in the same repository than the target

all_of_dir_subtree = $(if $(OBJ_DIR$1),$(call all_suffix,$1,$(OBJ_DIR$1)))\
					 $(foreach sub,$(SUBDIRS$1),$(call $0,$1$(sub)/,$2))
all_suffix = $(if $(suffix_list$1),\
			 $(foreach suffix_,$(suffix_list$1),$1$2$(suffix_)),$1$2)

# Rules to create needed directory (object, deps, etc)

$(call all_of_dir_subtree,$(srcdir),OBJ_DIR):
	$(QUIET) $(MKDIR) $@
