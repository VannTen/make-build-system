/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnumake.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/10/31 17:12:41 by mgautier          #+#    #+#             */
/*   Updated: 2017/10/31 17:19:16 by mgautier         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

/*
** Mock gnumake.h when gnumake is less than 4.0
*/

/* External interfaces usable by dynamic objects loaded into GNU Make.
--THIS API IS A "TECHNOLOGY PREVIEW" ONLY.  IT IS NOT A STABLE INTERFACE--
Copyright (C) 2013 Free Software Foundation, Inc.
This file is part of GNU Make.
GNU Make is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version.
GNU Make is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.  */

#ifndef _GNUMAKE_H_
#define _GNUMAKE_H_

/* Specify the location of elements read from makefiles.  */
typedef struct
{
const char *filenm;
unsigned long lineno;
} gmk_floc;


/* Run $(eval ...) on the provided string BUFFER.  */
void gmk_eval (const char *buffer, const gmk_floc *floc);

/* Run GNU make expansion on the provided string STR.
Returns an allocated buffer that the caller must free.  */
char *gmk_expand (const char *str);

/* Register a new GNU make function NAME (maximum of 255 chars long).
When the function is expanded in the makefile, FUNC will be invoked with
the appropriate arguments.
The return value of FUNC must be either NULL, in which case it expands to
the empty string, or a pointer to the result of the expansion in a string
created by malloc().  GNU make will free() the memory when it's done.
MIN_ARGS is the minimum number of arguments the function requires.
MAX_ARGS is the maximum number of arguments (or 0 if there's no maximum).
MIN_ARGS and MAX_ARGS must be >= 0 and <= 255.
If EXPAND_ARGS is 0, the arguments to the function will not be expanded
before FUNC is called.  If EXPAND_ARGS is non-0, they will be expanded.
*/
void gmk_add_function (const char *name,
char *(*func)(const char *nm, int argc, char **argv),
int min_args, int max_args, int expand_args);

char	*gmk_alloc(unsigned int len);
void	gmk_free(char *str);

#endif /* _GNUMAKE_H_ */
