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

add_executable(vmtest
	resolvefield_tests.c
	testHelpers.c
	vmstubs.c
	vmtest.c

	#TODO this should maybe be refactored?
	../../vm/description.c
	../../vm/KeyHashTable.c
	../../vm/ModularityHashTables.c
	../../vm/resolvefield.cpp
	../../vm/ObjectFieldInfo.cpp
	../../vm/segment.c
	../../vm/visible.c
	../../vm/vmthinit.c
	../../vm/stringhelpers.cpp
	$<TARGET_OBJECTS:j9vm_tracegen>
)

target_compile_definitions(vmtest
	PRIVATE
		J9VM_TEST
)

target_link_libraries(vmtest
	PRIVATE
		#j9vm_interface
		j9vm_gc_includes
		j9vm_main_wrapper

		j9exelib
		j9prt
		j9verutil
		j9util
		j9utilcore
		j9avl
		j9hashtable
		j9thr
		j9stackmap
		j9pool
		j9simplepool
		j9bcv
		j9dyn
		j9hookable
		j9vm
)

install(
	TARGETS vmtest
	RUNTIME DESTINATION ${j9vm_SOURCE_DIR}
)
