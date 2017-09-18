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

add_library(j9prt SHARED
	ut_j9prt.c
)

set(OBJECTS "")
list(APPEND OBJECTS 
	j9hypervisor.c
	j9hypervisor_common.c
	j9ipcmutex.c
	j9SysvIPCWrappers.c
	j9port.c
	j9process.c
	j9gs.c
	j9gp.c
	j9sharedhelper.c
	j9shmem.c
	j9shsem.c
	j9shsem_deprecated.c
	j9sock.c
	j9sockptb.c
	j9sysinfo.c
	j9sysinfo_helpers.c
	j9mem_basic.c
	j9portcontrol.c
)
if(OMR_ARCH_X86)
	list(APPEND OBJECTS
		j9hypervisor_i386.c
		#j9hypervisor_vmware.c
		j9sysinfo_helpers.c
	)
elseif(OMR_ARCH_POWER)
	list(APPEND OBJECTS j9hypervisor_systemp.c)
endif()

if(J9VM_PORT_RUNTIME_INSTRUMENTATION)
	list(APPEND OBJECTS j9ri.c)
endif()

#ut_j9prt

set(resolvedPaths "")
set(VPATH "")

if(OMR_ARCH_X86) #TODO and linux
	list(APPEND VPATH linuxamd64)
elseif(OMR_ARCH_POWER) #TODO and linux
	list(APPEND VPATH linuxppc)
endif()

list(APPEND VPATH
	linux
	sysvipc
	unix
	common
)

omr_find_files(resolvedPaths
	PATHS
	${VPATH}
	FILES
	${OBJECTS}
)

add_tracegen(common/j9prt.tdf)


target_sources(j9prt
	PRIVATE
	${resolvedPaths}
	$<TARGET_OBJECTS:omrport_obj>
)
target_link_libraries(j9prt 
	PUBLIC
		#omr_interface
		j9vm_interface

	
	PRIVATE
		j9vm_nls
		j9utilcore
		j9pool
		j9hashtable
		j9thr
		#TODO fix this
		dl
		rt

)

target_compile_definitions(j9prt
	PRIVATE
		-DJ9PORT_LIBRARY_DEFINE
)

target_include_directories(j9prt
	PRIVATE
		unix
		unix_include
	PUBLIC
		include
		common
	PRIVATE
		#TODO should be INTERFACE_INCLUDE_DIRECTORIES
		$<TARGET_PROPERTY:omrport_obj,INCLUDE_DIRECTORIES>
		${CMAKE_CURRENT_BINARY_DIR}
		${CMAKE_CURRENT_SOURCE_DIR}
)


install(
	TARGETS j9prt
	LIBRARY DESTINATION ${j9vm_SOURCE_DIR}
)
