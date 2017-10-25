#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   project_tree_traversal.mk                          :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:46:20 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/25 09:42:50 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# Calling this function ($(eval $(call $(DIR)))) will define the necessary rules
# for DIR
include directory_local_variables.mk
include Parse_one_dir.mk
include Collect.mk
include debug.mk
include target_rule.mk
include object_rules.mk
include target_recipes.mk
include Config.mk
include phony_rules_recipes.mk
include functions_tools.mk
include computed_local_var.mk
include global_rules.mk

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
# 1 : directory (=subtree)
# 2 : function to be applied on $1 before subtree parsing
# 3 : function to be applied on $1 after subtree parsing

define parse_the_graph

$(eval $(call $2,$1))

$(foreach subdir,\
	$(LIBRARY$1) $(SUBDIRS$1),\
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

SRC_TREE_ROOT ?= .
override SRC_TREE_ROOT := $(SRC_TREE_ROOT)/
intermediate_target_prefix := lib
intermediate_target_suffix := .a
OBJ_suffix := .o
SRC_suffix := .c
$(eval $(call parse_the_graph,$(SRC_TREE_ROOT),test,test_2))
#$(foreach dira,$(dir_list),$(eval $(call print_locals,$(dira))))

$(eval $(call global_rules,$(SRC_TREE_ROOT)))

.DEFAULT_GOAL:=

all: $(target$(SRC_TREE_ROOT))

fclean:
	$(QUIET) $(clean_targets)

clean:
	$(QUIET) $(clean_objects)

.PHONY: all fclean
