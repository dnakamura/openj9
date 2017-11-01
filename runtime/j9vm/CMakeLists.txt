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

# We dont want to suffix vm version to shared libs
set(CMAKE_SHARED_LIBRARY_SUFFIX ${J9VM_OLD_SHARED_SUFFIX})

#TODO this should be output in the binary dir, not the source dir
add_custom_command(OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/generated.h
	DEPENDS  ${CMAKE_CURRENT_SOURCE_DIR}/../oti/helpers.m4  ${CMAKE_CURRENT_SOURCE_DIR}/../redirector/forwarders.m4 generated.h.m4
	COMMAND m4 -I ${CMAKE_CURRENT_SOURCE_DIR}/../oti -I ${CMAKE_CURRENT_SOURCE_DIR}/../redirector ${CMAKE_CURRENT_SOURCE_DIR}/generated.h.m4 > generated.h
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)


add_tracegen(j9scar.tdf)

add_library(jvm_common INTERFACE)
target_sources(jvm_common INTERFACE
	${CMAKE_CURRENT_SOURCE_DIR}/generated.h
	${CMAKE_CURRENT_SOURCE_DIR}/j7verify.c
	${CMAKE_CURRENT_SOURCE_DIR}/j7vmi.c
	${CMAKE_CURRENT_SOURCE_DIR}/j8vmi.c
	${CMAKE_CURRENT_SOURCE_DIR}/j9memcategories.c
	${CMAKE_CURRENT_SOURCE_DIR}/java9vmi.c
	${CMAKE_CURRENT_SOURCE_DIR}/jvm.c
	${CMAKE_CURRENT_SOURCE_DIR}/vmi.c
	#TODO this is gross
	${CMAKE_CURRENT_SOURCE_DIR}/../hyvm/harmony_vm.c
)

target_link_libraries(jvm_common
	INTERFACE
		j9vm_interface
		j9vm_gc_includes

		j9exelib
		j9utilcore
		j9avl
		j9hashtable
		j9pool
		j9vmi
		pthread
		dl
)

target_include_directories(jvm_common
	INTERFACE
		#TODO we have to repeat ../include because of duplication of vmi.h
		../include
		../hyvm
		../harmony/include
		../jcl/
)

add_library(jvm SHARED ut_j9scar.c)
target_link_libraries(jvm
	PRIVATE
		jvm_common
		j9util
)
add_dependencies(jvm omrgc_hookgen)
target_compile_definitions(jvm
	PRIVATE
		-DJ9VM_JAVA9_BUILD=148
)

install(
	TARGETS jvm
	LIBRARY DESTINATION ${j9vm_SOURCE_DIR}
)
