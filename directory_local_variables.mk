#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   directory_local_variables.mk                       :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 17:13:09 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/25 08:53:57 by                  ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# This is a list of variables which shall be set in each directories in the 
# Srcs.mk file. The function is this file will stock their content
# in dir specific variables

local_variables_list :=\
	SRC\
	OBJ_DIR\
	SRC_DIR\
	INC_DIR\
	SUBDIRS\
	TARGET\
	TEST

# The function is intended to set the value of variable which are
# specific to each directory, that is, the list of source files, the various
# subdirs used (for sources, header, etc)
#
# It expect one argument, the name of the directory
#
define define_local_variables

$(foreach local_var,$(local_variables_list),\
	$(eval $(call assign_local,$1,$(local_var))))
endef


# This function assign to one directory specific variable its value.
# (which is based on the current global value of that variable)
# It expect the dir name as first argument, the variable name as second argument
# Should be used as eval
# After setting the the variable value for the current dir, it clear the value
# to avoid trouble later in computation
# 1 : dir name
# 2 : local variable name
# 

define assign_local
$2$1 := $($2)
$2 := $(NULL)
endef

# This function print the value given by the combination of a local variable and
# a directory (= the value of that local variable for that directory)
# The directory is the first argument, the variable the second
define get_local

$(info $($2_$1))

endef
