#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   General_rules.mk                                   :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/11/03 14:30:29 by mgautier          #+#    #+#             *#
#*   Updated: 2018/01/10 15:24:52 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# This file defines rules used across all the source tree, after it has been
# parsed. For example, it defines directory generation rules.

# Function to collect directory names accross the source tree,
# if they exist (if they dont, objects or deps or whatever else
# are simply in the same repository than the target

all_of_dir_subtree = $(if $($2$1),$(call all_suffix,$1,$($2$1)))\
					 $(foreach sub,$(SUBDIRS_$1),$(call $0,$1$(sub)/,$2))
all_suffix = $(if $(suffix_list$1),\
			 $(foreach suffix_,$(suffix_list$1),$1$2$(suffix_)),$1$2)

# Rules to create needed directory (object, deps, etc)
GENERATED_SUBDIRS := OBJ_DIR TEST_DIR

$(foreach dirs,$(GENERATED_SUBDIRS),\
	$(call all_of_dir_subtree,$(srcdir),$(dirs)_)):
	$(QUIET) $(MKDIR) $@
