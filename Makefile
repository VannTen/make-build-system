#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Makefile                                           :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 14:28:22 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/31 15:02:10 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# Functions definitions
include Dir_traversal.mk
include Dir_var.mk
include Dir_rules.mk

# Tools variable settings
include Config.mk

# Parsing the source tree for source files and establishing rules for each
# target and local dependencies (aka object files)

$(call Apply_to_src_tree,$(srcdir),define_local_variables,Dir_rules)

# Define standard make targets to be used by the make invoker, and link them to
# the main target (= the default target of the source tree root directory)

include Standard_targets.mk
