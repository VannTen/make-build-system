#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Unit_tests.mk                                      :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/11/03 14:51:37 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/08 15:53:01 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# This file define rules that allow to accomplish unit test (could be at the
# same time as compilation, or separately)
# Their should be one test by source file (this is under the assumptions that
# most files defines a quite independant functionnality).
# However, it is possible to have functionnality which uses others, and so the 
# test should also link against the directory library (->intermediate target)

# For each source file, one phony rule to test it.
# For each directory, one phony rule to test all source files.
# For each invocation of make, one phony rule to test all source files of all
# directory.
#
# Includes a switch to enable or disable test locally (when they have not be
# written yet)

local_variables_list_unit_test :=\
	TEST_DIR\
	TEST_SRC_DIR\
	DONT_TEST\
	STATIC_TEST_FILES


# All needed variables

to_test = $(filter-out $(DONT_TEST$1),$(SRC$1))
tests = $(patsubst %$(src_suffix),$(test_bin_dir)/%.last,$(to_test))
test = test_$1
test_exes = $(patsubst %$(src_suffix),$(test_bin_dir)/%,$(to_test))
test_files = $(patsubst %,$(test_src_dir)/%,$(SRC$1))
static_test_files = $(patsubst %,$(test_src_dir)/%,$(STATIC_TEST_FILES$1))

test_bin_dir = $1$(TEST_DIR$1)
test_src_dir = $1$(TEST_SRC_DIR$1)

# Recipes
define RUN_TEST
$(if $(findstring $(CURDIR),$<),,./)$^
$(TOUCH) $@
endef

define BUILD_TEST
$(CC) $(cflags) $(cppflags) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $^ -o $@
endef

# Main rule, applied by directory

Unit_tests = $(if $(TEST_DIR$1),$(Unit_tests_intern))

define Unit_tests_intern

.PHONY: $(test)

$(test): $(tests)

$(test): include := $(compile_time_include)

$(tests):$(test_bin_dir)/%.last:$(test_bin_dir)/% $(static_test_files)
	$(QUIET) $$(RUN_TEST)

$(test_exes):\
	$(test_bin_dir)/%:\
	 $(test_src_dir)/%$(src_suffix)\
	 $(ext_dependencies) $(patsubst lib%,-l%,$(LIBRARIES$1)) | $(test_bin_dir)
	$(QUIET) $$(BUILD_TEST)

endef
