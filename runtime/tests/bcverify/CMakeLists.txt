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

# TODO this is kinda gross, but cmake cant seem to figure out
# files generated in other CMakeLists.txts
#add_tracegen(${j9vm_SOURCE_DIR}/bcverify/j9bcverify.tdf)
add_library(bcuwhite SHARED
	natives/bcvnatives.c

	#TODO this is kinda gross. Should be refactores
	../../bcverify/bcverify.c
	../../bcverify/clconstraints.c
	../../bcverify/rtverify.c
	../../bcverify/staticverify.c
	../../bcverify/vrfyconvert.c
	../../bcverify/vrfyhelp.c
	$<TARGET_OBJECTS:j9bcv_tracegen>
	#ut_j9bcverify.c
)
add_dependencies(bcuwhite j9bcv)

target_link_libraries(bcuwhite
	PRIVATE
		j9vm_interface
		j9vm_gc_includes
		#j9bcv_tracegen

		j9verutil
		j9util
		j9utilcore
		j9avl
		j9hashtable
		j9pool
		j9thr
		j9stackmap
)

target_include_directories(bcuwhite
	PRIVATE
		${j9vm_SOURCE_DIR}/shared_common/include
)

install(
	TARGETS bcuwhite
	LIBRARY DESTINATION ${j9vm_SOURCE_DIR}
)
