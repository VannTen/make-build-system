#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Standard_targets.mk                                :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 15:04:08 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/03 15:57:47 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

# This file provide the standard targets expected by the avarage make user.
# It also establish all as the default goal when no target is specified on the
# command line.

standard_targets := all clean fclean re

all: $(call target,$(srcdir)) ## Build the default target for that directory

all_of = $(info $1 $2)$(call $1,$2) $(foreach sub,$(SUBDIRS),$(call $0,$2$(sub)/))

clean: ## Clean object files
	$(QUIET) $(RM) $(call all_of,objects,$(srcdir))

fclean: clean ## Same as clean, but also clean the targets
	$(QUIET) $(RM) $(call all_of,intermediate_target,$(srcdir))\
		$(call target,$(srcdir))

re: fclean all ## Redo a clean build (unsafe with --jobs)

check: $(call test,$(srcdir)) ## Perform unit tests

# WARNING : The 're' rules will break on a parallel build, since make will
# attempt to do 'fclean' and 'all' at the same time, effectively building and
# erasing at the same time.
#
# But anyway, doing 'clean' builds is only the consequence of broken Makefiles
# which cannot provide correct incremental builds. So it is perfectly obvious
# that no one will need that rule when using that beautiful, perfect Makefile.
# Isn't it ?

.PHONY: $(standard_targets)
.DEFAULT_GOAL := all

## Help target, print informations about each standard target
##  (credit for that shell command goes to Brikou Carre)
## https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: all ## Print this help
	$(QUIET)grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)\
		| awk 'BEGIN {FS = ":.*?## "};\
		{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
