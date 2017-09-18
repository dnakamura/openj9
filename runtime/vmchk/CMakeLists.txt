################################################################################
# Copyright (c) 2017, 2017 IBM Corp. and others
#
# This program and the accompanying materials are made available under
# the terms of the Eclipse Public License 2.0 which accompanies this
# distribution and is available at https://www.eclipse.org/legal/epl-2.0/
# or the Apache License, Version 2.0 which accompanies this distribution and
# is available at https://www.apache.org/licenses/LICENSE-2.0.
#
# This Source Code may also be made available under the following
# Secondary Licenses when the conditions for such availability set
# forth in the Eclipse Public License, v. 2.0 are satisfied: GNU
# General Public License, version 2 with the GNU Classpath
# Exception [1] and GNU General Public License, version 2 with the
# OpenJDK Assembly Exception [2].
#
# [1] https://www.gnu.org/software/classpath/license.html
# [2] http://openjdk.java.net/legal/assembly-exception.html
#
# SPDX-License-Identifier: EPL-2.0 OR Apache-2.0
################################################################################

add_tracegen(j9vmchk.tdf)

add_library(j9vmchk SHARED
	checkclasses.c
	checkclconstraints.c
	checkinterntable.c
	checkmethods.c
	checkromclasses.c
	checkthreads.c
	vmcheck.c

	ut_j9vmchk.c
)

target_link_libraries(j9vmchk
	PRIVATE
		j9vm_interface
		j9vm_gc_includes

		j9thr
		j9util
		j9utilcore
		j9hashtable
)

install(
	TARGETS j9vmchk
	LIBRARY DESTINATION ${j9vm_SOURCE_DIR}
)
