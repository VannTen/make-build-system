#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 14:28:22 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/05 14:04:43 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# Makefile all-purpose functions
include $(makefiles_dir)/dir_relative_macros.mk

# Functions definitions
include $(makefiles_dir)/Dir_traversal.mk
include $(makefiles_dir)/Dir_var.mk
include $(makefiles_dir)/Dir_rules.mk
include $(makefiles_dir)/Lib_rules.mk
include $(makefiles_dir)/Unit_tests.mk

# Tools variable settings
include $(makefiles_dir)/Config.mk

# Canonize source tree
#
# This litte part is essential to ensure the source tree root is of the form
# dir/. Extra '/' are of no signifiance to most Unix path interpretation, so
# that will do for now.
# Also default $(srcdir) to the current dirrectory (for make)

srcdir ?= .
override srcdir := $(srcdir)/

# Parsing the source tree for source files and establishing rules for each
# target and local dependencies (aka object files)

$(eval $(call Apply_to_src_tree,$(srcdir),define_local_variables))
$(eval $(call Apply_to_src_tree,$(srcdir),Dir_rules Unit_tests))


# Define rules for directories and other kind of simple global rules
include $(makefiles_dir)/General_rules.mk

# Define standard make targets to be used by the make invoker, and link them to
# the main target (= the default target of the source tree root directory)

include $(makefiles_dir)/Standard_targets.mk
