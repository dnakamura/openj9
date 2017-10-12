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

#TODO scope b165
add_library(jclse9_156 SHARED
	../j9vmconstantpool_se9.c
)
target_include_directories(jclse9_156
	PRIVATE
		${CMAKE_CURRENT_BINARY_DIR}
		../
)

target_compile_definitions(jclse9_156
	PRIVATE
		J9VM_JCL_SE9
)

target_link_libraries(jclse9_156
	PRIVATE
		j9vm_interface
		j9vm_gc_includes
		j9vm_jcl_includes
		j9vm_jcl_tracegen
		omrsig

		j9vm_jcl_se6_vm-side_lifecycle
		j9vm_jcl_se6_vm-side_natives
		j9vm_jcl_jithelpers
		j9vm_jcl_sun_misc_Unsafe
		j9vm_jcl_attach
		j9vm_jcl_se7
		j9vm_jcl_se8
		j9vm_jcl_se9
		#pthread
		j9hookable
		j9zlib
		j9util
		j9utilcore
		j9avl
		j9hashtable
		j9pool
		#j9fdlibm
		j9thr
		j9vmi
		sunvmi
)
set_target_properties(jclse9_156 PROPERTIES LIBRARY_OUTPUT_NAME jclse9_)

install(
	TARGETS jclse9_156
	LIBRARY DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}
)
