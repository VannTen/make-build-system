#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Collect.mk                                         :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:35:46 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/25 09:39:05 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# These three variables collect respectively : 
# all object files, target files and dependencies files, 
# and submakefiles (that can be generated).

CLEAN :=
FCLEAN :=
MKCLEAN :=

# Initializes as simple variables collector for, respectively,
# library path (used for compilation rules)
# directories that may not exist at build time and are required 
# (objects directories and dependencies directories)
# and dependencies files.

LIBPATH_INC :=
GENERATED_SUBDIRS :=
DEP_FILES :=

#
#

# Keep the list of all directory that have been parsed
DIR_LIST:=

add_to = $($1):=$($1) $($2)

# Global variable list

global_variables_list :=\
	DIR_LIST\
	GENERATED_SUBDIRS

define	collect_global_variables
dir_list := $(dir_list) $1
endef

# 1 : subtree (dir_name)
# 2 : variable to collect
all_of_subtree = $($2$1) $(foreach sub,$(SUBDIRS$1),$(call $0,$1$(sub)/,$2))

all_dir = $1 $(call all_of_subtree,$1,SUBDIRS)

