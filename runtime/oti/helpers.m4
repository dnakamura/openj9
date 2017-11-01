divert([-1])
define([mshift],
	[ifelse($1,0,[shift($@)],[mshift([decr($1)],shift(shift($@)))])])
	
define([get_arg_type],[patsubst([$1],[ [^ *]*$])])
define([get_arg_name],[ifelse([$1],[void],[],[substr([$1],regexp([$1],[[^ *]*$]))])])


define([crappy],[ifelse($1,1,a,b)])
dnl _make_arg_helper(type, name, arg_number)
define([_make_arg_helper],[ifelse([$2],[],[arg$3],[$2])])

define([make_arg_list_impl_bak],
	[ifelse([$#],[2],
		[[$2 arg$1]],
		[[$2 arg$1], make_arg_list_impl(incr($1),shift(shift($@)))])])
define([evaltest],[eval($# <= 2)])
define([make_arg_list_bak],[make_arg_list_impl(1,$@)])
define([make_arg_list_2_impl],
	[$2 _make_arg_helper([$2],[$3],[$1]) ifelse(eval($# > 3),[1],[, make_arg_list_2_impl(incr($1),mshift(3,$@))])])

define([args_test],[ eval($# >= 3) - ifelse(eval($# >= 3),[1],[A],[B])])
define([make_arg_list_2],[make_arg_list_2_impl(1,$@)])


define([arg_names_list], [get_arg_name([$1])[]ifelse(eval($# >= 2),[1],[, arg_names_list(shift($@))])])
define([strip_r], [patsubst([$1], [ *$])])
define([strip],
	[patsubst(strip_r([$1]),[^ *])])
define([invokePrefix], [ifelse(strip($1),[void],,[return ])])dnl

define([type_is_ptr],[ifelse(index($1,[*]),[-1],[0],[1])])
define([type_is_wide],[ifelse($1,[jlong],[1],$1,[jdouble],1,0)])
define([get_arg_size_impl],[ifelse(type_is_ptr($1),[1],[4],type_is_wide($1),[1],[8],ifelse($1,[void],0,4))])
define([get_arg_size],[get_arg_size_impl(strip(get_arg_type($1)))])
define([get_function_arg_size_impl], [get_arg_size($1) ifelse(eval($# >= 2),[1],[+ get_function_arg_size_impl(shift($@))])])
define([get_function_arg_size], [eval(get_function_arg_size_impl($@))])

define([decorate_impl], [_$1@get_function_arg_size(mshift(4,$@))])
define([decorate_function_name], [ifelse($3,[true],decorate_impl($@),$1)])
# join(sep, args) - join each non-empty ARG into a single
# string, with each element separated by SEP
define([join],
[ifelse([$#], [2], [[$2]],
  [ifelse([$2], [], [], [[$2]_])$0([$1], shift(shift($@)))])])
define([_join],
[ifelse([$#$2], [2], [],
  [ifelse([$2], [], [], [[$1$2]])$0([$1], shift(shift($@)))])])
# joinall(sep, args) - join each ARG, including empty ones,
# into a single string, with each element separated by SEP
define([joinall], [[$2]_$0([$1], shift($@))])
define([_joinall],
[ifelse([$#], [2], [], [[$1$3]$0([$1], shift(shift($@)))])])
divert[]dnl
