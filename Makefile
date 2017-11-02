#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 14:28:22 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/02 14:56:28 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# Functions definitions
include Dir_traversal.mk
include Dir_var.mk
include Dir_rules.mk

# Tools variable settings
include Config.mk

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
$(eval $(call Apply_to_src_tree,$(srcdir),Dir_rules))

# Function to collect directory names accross the source tree,
# if they exist (if they dont, objects or deps or whatever else
# are simply in the same repository than the target

all_of_dir_subtree = $(foreach dir_name,$2,\
					 $(if $($(dir_name)$1),$1$($(dir_name)$1)))\
					 $(foreach sub,$(SUBDIRS$1),$(call $0,$1$(sub)/,$2))

all_suffix = $(foreach suffix_,$(suffix_list$1),$(addsuffix $(suffix_),$2))
# Rules to create needed directory (object, deps, etc)

$(call all_of_dir_subtree,$(srcdir),OBJ_DIR):
	$(QUIET) $(MKDIR) $@


# Define standard make targets to be used by the make invoker, and link them to
# the main target (= the default target of the source tree root directory)

include Standard_targets.mk
