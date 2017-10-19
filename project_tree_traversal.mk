#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   project_tree_traversal.mk                          :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:46:20 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 18:22:39 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# Calling this function ($(eval $(call $(DIR)))) will define the necessary rules
# for DIR
include directory_local_variables.mk
include Parse_one_dir.mk

define include_dir_infos
include $1Srcs.mk
endef

define empty_dir_srcs
SUBDIRS:=
endef

# That function walks the whole project tree.
# It expect three arguments : first is the directory to be parsed,
# second is the function to be applied before parsing the subtree, 
# third is the function to be applied after parsing the subtree,
define parse_the_graph

$(eval $(call $2,$1))

$(foreach subdir,\
	$(LIBRARY) $(SUBDIRS$1),\
	$(eval $(call $0,$1$(subdir)/,$2,$3)))

$(eval $(call $3,$1))
endef

define test
$(info Stepping in $1)
$(eval $(call parse_one_dir,$1))
endef

define test_2
$(info Stepping out of $1)
endef

$(eval $(call parse_the_graph,./,test,test_2))

all:
