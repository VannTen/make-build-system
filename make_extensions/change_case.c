/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   change_case.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mgautier <mgautier@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/10/31 16:56:17 by mgautier          #+#    #+#             */
/*   Updated: 2017/10/31 17:24:12 by mgautier         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include "gnumake.h"
#include <stddef.h>

static char	*change_case(const char *src, t_bool lower)
{
	size_t	index;
	size_t	size;
	char	*expand_result;

	index = 0;
	size = ft_strlen(src);
	expand_result = gmk_alloc(size + 1);
	if (expand_result != NULL)
	{
		while (index < size)
		{
			if (src[index] <= (lower ? 'z' : 'Z')
					&& src[index] >= (lower ? 'a' : 'A'))
				expand_result[index] = src[index] +
					(lower ? -'a' + 'A' : -'A' + 'a');
			else
				expand_result[index] = src[index];
		}
		index++;
	}
	return (expand_result);
}

char		*upper_case(const char *src)
{
	return (change_case(src, FALSE));
}

char		*lower_case(const char *src)
{
	return (change_case(src, TRUE));
}
