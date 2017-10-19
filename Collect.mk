#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Collect.mk                                         :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:35:46 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 18:05:25 by mgautier         ###   ########.fr       *#
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
