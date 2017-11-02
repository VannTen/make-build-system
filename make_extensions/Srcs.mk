#* ************************************************************************** *#
#*                                                                            *#
#*                                                        :::      ::::::::   *#
#*   Srcs.mk                                            :+:      :+:    :+:   *#
#*                                                    +:+ +:+         +:+     *#
#*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        *#
#*                                                +#+#+#+#+#+   +#+           *#
#*   Created: 2017/10/31 16:51:59 by mgautier          #+#    #+#             *#
#*   Updated: 2017/11/02 14:08:14 by mgautier         ###   ########.fr       *#
#*                                                                            *#
#* ************************************************************************** *#

TARGET := libmake

SRC :=\
	change_case.c

SRC_DIR :=
INC_DIR := includes
OBJ_DIR := object
DEP_DIR := .dep

# Dependencies : component and library.

COMPONENTS := 
LIBRARIES := libft
