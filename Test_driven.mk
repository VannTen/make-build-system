#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Test_driven.mk                                     :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:39:05 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 15:39:21 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

##
## Testing 
##

UNIT_TESTS = $(patsubst %.c, $(DIR)test_bin/%, $(SRC_$(DIR)))
define UNIT_TEST_RULE
$(UNIT_TESTS): $(DIR)test_bin/%: $(INTERMEDIATE_TARGET) $(LIB_TEST)\
	$$(patsubst lib%,-l$$(BUILD_PREFIX)%,$$(LIBS_$$(DIR)))\
	| $(DIR)test_bin/
	$$(LINK_TEST) 
	$(QUIET)$(CC) -xc\
	<(echo -e "int main(void){return (test_$$(notdir $$@)());}")\
	$(CFLAGS) $$(CPPFLAGS) $(LDFLAGS) $(LD_OPTI_FLAGS)\
	$$^

$(addsuffix .latest_test, $(UNIT_TESTS)): %.latest_test: %
	$$(QUIET)echo Testing $$(subst test_bin/,,$$<).c ...
	$$(QUIET)./$$< || ( echo "Error on $$<, invoking $$(DEBUGGER)";\
		$$(DEBUG_TEST_INVOK) ./$$< && exit 1 )
	$$(QUIET)touch $$@
	$$(QUIET)echo $$(subst test_bin/,,$$<).c : check !

GENERATED_SUBDIRS += $(DIR)test_bin/
endef

define TEST_RULE
$(DIR)_test: $(addsuffix .latest_test, $(UNIT_TESTS))

ALL_TESTS := $(ALL_TESTS) $(DIR)_test
endef

