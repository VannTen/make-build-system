#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Top_rules.mk                                       :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 15:37:09 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 15:38:27 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#


##
## Standard rules for users
##

# $(TARGET_$(DIR) will expand in $(TARGET_), since DIR will recover 
# its initial value and the end of the parsing of the Rules.mk files
# (see the standard entry and exit gates on Rules.mk)

# Because the Norm said so.................

NAME = ___name___
all: $(DEFAULT_RULE)

test: $(ALL_TESTS)

opti debug profile syn: $(NAME)

$(NAME): $(TARGET_$(DIR)) test

# Make sure the default target is always all
.DEFAULT_GOAL:= all

clean:
	$(QUIET)$(RM) $(CLEAN)

mkclean:
	$(QUIET)$(RM) $(MKCLEAN)

fclean: clean
	$(QUIET)$(RM) $(FCLEAN)

dirclean:
	$(QUIET)$(RMDIR) $(GENERATED_SUBDIRS)

mrproper: fclean mkclean

re: fclean all

syn: CFLAGS := $(CFLAGS) $(SYNTAX_FLAGS)
syn: QUIET := @
syn: LDFLAGS := $(LDFLAGS) $(SYNTAX_FLAGS)
debug: CFLAGS := $(CFLAGS) $(DEBUG_FLAGS)
debug: LDFLAGS := $(LDFLAGS) $(DEBUG_FLAGS)
opti: CFLAGS := $(CFLAGS) $(OPTI_CFLAGS)
opti: LDFLAGS := $(LDFLAGS) $(OPTI_LDFLAGS)
profile: CFLAGS := $(CFLAGS) $(PROFILE_FLAGS)
profile: LDFLAGS := $(LDFLAGS) $(PROFILE_FLAGS)
.PHONY: $(NAME) debug all clean fclean mkclean dirclean re test $(ALL_TESTS)
