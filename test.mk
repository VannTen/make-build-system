#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   test.mk                                            :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/19 18:34:02 by mgautier          #+#    #+#             *#
#*   Updated: 2017/10/19 18:38:59 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

define test
$2$1 := test
$2 :=
endef

$(foreach a,a b c d,$(eval $(call test,st,$a)))

$(info $(a))
$(info $(b))
$(info $(c))
$(info $(d))
$(info $(ast))
$(info $(bst))
$(info $(cst))
$(info $(dst))
all:
