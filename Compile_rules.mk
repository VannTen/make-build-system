#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Compile_rules.mk                                   :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:30:12 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 15:35:55 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

#
# The value of INCLUDE and LIB_INCLUDES is set with targets-specific variable,
# in each directory.
# 


CPPFLAGS += $(foreach INC,$(INCLUDE),-iquote$(INC))\
			$(foreach INC_LIB,$(LIB_INCLUDES),-iquote$(INC_LIB))
DEPFLAGS = -MT $@ -MP -MMD -MF $(word 2,$^).tmp


COMPILE = $(CC) $(DEPFLAGS) $(OPTI_FLAGS) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

# Post processing on depencency file (done after compilation) for relative path.
POSTCOMPILE = $(SED)\
  -e 's|$(OBJ_LOCAL_$(DIR))\([$(FILE_CHAR_RANGE)]*\.o\)|$$(OBJ_LOCAL_$(DIR))\1|g'\
  -e 's|$(SRC_LOCAL_$(DIR))\([$(FILE_CHAR_RANGE)]*\.c\)|$$(SRC_LOCAL_$(DIR))\1|g'\
  -e 's|$(INC_LOCAL_$(DIR))\([$(FILE_CHAR_RANGE)]*\.h\)|$$(INC_LOCAL_$(DIR))\1|g'\
  $(foreach LIB,$($(DIR)_LIBS),-e \
 's|$($(LIB)_PATH)\([$(FILE_CHAR_RANGE)]*\.h\)|$$($(LIB)_PATH)\1|g')\
  $(word 2,$^).tmp > $(word 2,$^)


# Compilation rule for objects files (.o) from C source files (.c)
# Generate dependencies files (.dep) as a side effet
# That macro is used with eval in each subdirs to generate a static pattern rule
# for the objects files in that directory

%.o: %.c

define	STATIC_OBJ_RULE
$(OBJ_$(DIR)): $(OBJ_LOCAL_$(DIR))%.o: $(SRC_LOCAL_$(DIR))%.c\
$(DEP_LOCAL_$(DIR))%.dep | $(OBJ_LOCAL_$(DIR)) $(DEP_LOCAL_$(DIR))
	$(if $(PRINT_INFO), $$(info Compiling $$@ ...))
	$$(QUIET) $$(COMPILE)
	$$(QUIET) $$(POSTCOMPILE)
	$$(QUIET) $(RM) $$(word 2,$$^).tmp
	$$(QUIET) $(TOUCH) $$@
endef

%.dep: ;

.PRECIOUS: %.dep
