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

cmake_minimum_required(VERSION 3.4 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules" "${CMAKE_CURRENT_SOURCE_DIR}/omr/cmake/modules" ${CMAKE_MODULE_PATH})

set(J9VM_VERSION_MAJOR 2)
set(J9VM_VERSION_MINOR 9)
set(J9VM_VERSION_PATCH 0)
set(J9VM_VERSION ${J9VM_VERSION_MAJOR}.${J9VM_VERSION_MINOR}.${J9VM_VERSION_PATCH})

#hack to suppress omr warnings as errors
set(OMR_WARNINGS_AS_ERRORS OFF)

set(J9VM_JAVA_VERSION "9" CACHE STRING "Version of Java to build")
set_property(CACHE J9VM_JAVA_VERSION PROPERTY STRINGS "8" "9")

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

project(j9vm VERSION ${J9VM_VERSION} LANGUAGES CXX C)
if(CMAKE_CXX_COMPILER_ID STREQUAL "XL")
	set(CMAKE_CXX_IMPLICIT_LINK_LIBRARIES "")
endif()


enable_language(ASM)
#add_definitions(-pthread)
SET(CMAKE_INSTALL_RPATH "\$ORIGIN")

set(OMR_GLUE_TARGET "j9vm_glue" CACHE STRING "The glue target")
set(OMR_GC_GLUE_TARGET "j9vm_gc_glue" CACHE STRING "")
set(OMR_RAS_GLUE_TARGET "j9vm_ras_glue" CACHE STRING "")
set(OMR_CORE_GLUE_TARGET "j9vm_core_glue" CACHE STRING "")
set(OMR_UTIL_GLUE_TARGET "j9vm_util_glue" CACHE STRING "")

include(cmake/platform.cmake)
include(cmake/optional_compile.cmake)


#TODO should probably rename to j9vm_jit_defines for less ambiguity
add_library(j9vm_compiler_defines INTERFACE)

if(OMR_ENV_DATA64)
	target_compile_definitions(j9vm_compiler_defines INTERFACE TR_64bit TR_HOST_64BIT TR_TARGET_64BIT)
else()
	target_compile_definitions(j9vm_compiler_defines INTERFACE TR_HOST_32BIT TR_TARGET_32BIT)
endif()

if(OMR_ARCH_X86)
	target_compile_definitions(j9vm_compiler_defines INTERFACE TR_TARGET_X86 TR_HOST_X86)
elseif(OMR_ARCH_POWER)
	target_compile_definitions(j9vm_compiler_defines INTERFACE TR_TARGET_POWER TR_HOST_POWER)
endif() #TODO OTHER PLATFORMS

#TODO should use findCuda
include_directories( /usr/local/cuda-5.5/include )


#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/lib")

add_library(j9vm_interface INTERFACE)

target_include_directories(j9vm_interface
	INTERFACE
		oti
		include
		omr/include_core
		${CMAKE_CURRENT_BINARY_DIR}/omr
		nls
)

#TODO deprecated
add_library(j9vm_nls INTERFACE)
target_include_directories(j9vm_nls 
	INTERFACE

)


add_library(j9vm_gc_includes INTERFACE)
target_include_directories(j9vm_gc_includes
	INTERFACE
		$<TARGET_PROPERTY:omrgc,INTERFACE_INCLUDE_DIRECTORIES>
		${j9vm_SOURCE_DIR}/gc_include
		${j9vm_SOURCE_DIR}/gc_glue_java
		${j9vm_SOURCE_DIR}/gc_base
		${j9vm_SOURCE_DIR}/gc_stats
		${j9vm_SOURCE_DIR}/gc_structs
)

#setup OMR library overrides
set(OMR_GC_LIB "j9gc" CACHE STRING "Name of the GC library to use")
set(OMR_HOOK_LIB "j9hookable" CACHE STRING "Name of the hook library to link against")
set(OMR_PORT_LIB "j9prt" CACHE STRING "Name of the port library to link against")
set(OMR_THREAD_LIB "j9thr" CACHE STRING "Name of the thread library to link against")
set(OMR_TRACE_LIB "j9trc" CACHE STRING "Name of the trace library to link against")

add_subdirectory(gc_glue_java)
add_subdirectory(omr)

set_target_properties(omrsig PROPERTIES LINKER_LANGUAGE C)

# Do out hookgen stuff
add_hookgen(oti/j9jit.hdf ${CMAKE_CURRENT_SOURCE_DIR}/oti/jithook.h ${CMAKE_CURRENT_SOURCE_DIR}/oti/jithook_internal.h)
add_hookgen(oti/j9vm.hdf ${CMAKE_CURRENT_SOURCE_DIR}/oti/vmhook.h ${CMAKE_CURRENT_SOURCE_DIR}/oti/vmhook_internal.h)
add_hookgen(oti/zipCachePool.hdf ${CMAKE_CURRENT_SOURCE_DIR}/oti/vmzipcachehook.h ${CMAKE_CURRENT_SOURCE_DIR}/oti/vmzipcachehook_internal.h)
add_hookgen(gc_include/j9mm.hdf ${CMAKE_CURRENT_SOURCE_DIR}/include/mmhook.h ${CMAKE_CURRENT_SOURCE_DIR}/gc_base/mmhook_internal.h)

add_custom_target(j9vm_hookgen
	DEPENDS
	${CMAKE_CURRENT_SOURCE_DIR}/oti/jithook.h
	${CMAKE_CURRENT_SOURCE_DIR}/oti/vmhook.h
	${CMAKE_CURRENT_SOURCE_DIR}/oti/vmzipcachehook.h
	${CMAKE_CURRENT_SOURCE_DIR}/include/mmhook.h
)

add_dependencies(j9vm_interface
		${CMAKE_CURRENT_SOURCE_DIR}/oti/jithook.h
		${CMAKE_CURRENT_SOURCE_DIR}/oti/vmhook.h
		${CMAKE_CURRENT_SOURCE_DIR}/oti/vmzipcachehook.h
)
add_dependencies(j9vm_interface j9vm_hookgen)
if(TARGET omrglue)
	set(J9VM_LEGACY_GLUE 1)
else()
	set(J9VM_LEGACY_GLUE 0)
endif()

set(J9VM_OLD_SHARED_SUFFIX ${CMAKE_SHARED_LIBRARY_SUFFIX})
set(CMAKE_SHARED_LIBRARY_SUFFIX "29${CMAKE_SHARED_LIBRARY_SUFFIX}")

if(J9VM_MODULE_BCUTIL)
	add_subdirectory(bcutil)
endif()
if(J9VM_MODULE_BCVERIFY)
	add_subdirectory(bcverify)
endif()
if(J9VM_MODULE_CASSUME)
	add_subdirectory(cassume)
endif()
if(J9VM_MODULE_CFDUMPER)
	add_subdirectory(cfdumper)
endif()
add_subdirectory(clear_vmi)
if(J9VM_MODULE_CODERT_VM)
	add_subdirectory(codert_vm)
endif()
add_subdirectory(cuda)
if(J9VM_MODULE_DBGEXT)
	add_subdirectory(dbgext)
endif()
#add_subdirectory(ddr_plugin)
#add_subdirectory(ddrext)
if(OMR_HOST_OS STREQUAL "win")
	#add_subdirectory(dfix)
endif()
if(J9VM_MODULE_EXELIB)
	add_subdirectory(exelib)
endif()
if(J9VM_MODULE_FLSANITY)
	add_subdirectory(flsanity)
endif()
if(J9VM_MODULE_GC)
	add_subdirectory(gc)
endif()
if(J9VM_MODULE_GC_API)
	add_subdirectory(gc_api)
endif()
if(J9VM_MODULE_GC_BASE)
	add_subdirectory(gc_base)
endif()
if(J9VM_MODULE_GC_CHECK)
	add_subdirectory(gc_check)
endif()
if(J9VM_MODULE_DDR)
	#add_subdirectory(gc_ddr)
endif()
if(J9VM_MODULE_GC_MODRON_STANDARD)
	add_subdirectory(gc_modron_standard)
endif()
if(J9VM_MODULE_GC_MODRON_STARTUP)
	add_subdirectory(gc_modron_startup)
endif()
if(J9VM_MODULE_GC_REALTIME)
	add_subdirectory(gc_realtime)
endif()
if(J9VM_MODULE_GC_STACCATO)
	add_subdirectory(gc_staccato)
endif()
if(J9VM_MODULE_GC_STATS)
	add_subdirectory(gc_stats)
endif()
if(J9VM_MODULE_GC_STRUCTS)
	add_subdirectory(gc_structs)
endif()
add_subdirectory(gc_tests)
if(J9VM_MODULE_GC_TRACE)
	add_subdirectory(gc_trace)
	if(J9VM_MODULE_GC_MODRON_STANDARD)
		add_subdirectory(gc_trace_standard)
	endif()
	if(J9VM_GC_VLHGC)
		add_subdirectory(gc_trace_vlhgc)
	endif()
endif()
if(J9VM_MODULE_GC_REALTIME)
	add_subdirectory(gc_verbose_handler_realtime)
endif()
if(J9VM_MODULE_GC_MODRON_STANDARD)
	add_subdirectory(gc_verbose_handler_standard_java)
endif()

add_subdirectory(gc_verbose_handler_vlhgc)
add_subdirectory(gc_verbose_java)
add_subdirectory(gc_verbose_old)
add_subdirectory(gc_verbose_old_events)
add_subdirectory(gc_vlhgc)
add_subdirectory(gcchk)
add_subdirectory(gdb_plugin)
add_subdirectory(harmony)
#add_subdirectory(hyvm)
add_subdirectory(j9vm)
add_subdirectory(j9vm_b150)
add_subdirectory(j9vm_b156)
add_subdirectory(jcl)
if(J9VM_MODULE_JEXTRACTNATIVES)
	add_subdirectory(jextractnatives)
endif()
add_subdirectory(jilgen)
add_subdirectory(jit_vm)
add_subdirectory(jnichk)
add_subdirectory(jniinv)
add_subdirectory(jsigWrapper)
add_subdirectory(jvmti)
add_subdirectory(libffi)
add_subdirectory(mgmt)
add_subdirectory(port)
add_subdirectory(rasdump)
add_subdirectory(rastrace)
#add_subdirectory(redirector)
add_subdirectory(runtimetools)
add_subdirectory(shared)
add_subdirectory(shared_common)
add_subdirectory(shared_util)
add_subdirectory(simplepool)
add_subdirectory(stackmap)
add_subdirectory(sunvmi)
add_subdirectory(thrtrace)
if(OMR_HOST_ARCH STREQUAL "x86" OR OMR_HOST_ARCH STREQUAL "ppc")
	#jit only does x86 at the moment
	if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		add_subdirectory(tr.source/trj9)
	endif()
endif()

add_subdirectory(util)
add_subdirectory(util_core)
add_subdirectory(verbose)
add_subdirectory(verutil)
add_subdirectory(vm)
add_subdirectory(vmchk)
#add_subdirectory(win)
#add_subdirectory(win_64)
#add_subdirectory(windbg)
add_subdirectory(zip)
add_subdirectory(zlib)
add_library(j9thr SHARED
	$<TARGET_OBJECTS:j9thr_obj>
)
target_link_libraries(j9thr
	PRIVATE
		j9pool
		j9utilcore
		j9vm_interface
	PUBLIC
		pthread #TODO wrap in platform detection
		rt
)


add_subdirectory(tests)

add_library(j9hookable SHARED
	$<TARGET_OBJECTS:j9hook_obj>
)

target_link_libraries(j9hookable
	PRIVATE
		j9pool
		j9prt
		j9thr
)

install(
	TARGETS j9thr j9hookable
	LIBRARY DESTINATION ${j9vm_SOURCE_DIR}
)

add_library(j9vm_main_wrapper INTERFACE)
target_sources(j9vm_main_wrapper INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/makelib/cmain.c)
target_link_libraries(j9vm_main_wrapper
	INTERFACE
		j9thr
		j9prt
)
set_target_properties(
	balloon
	bcuwhite
	cuda4j
	gdb_j9
	hyprtshim
	hythr
	j9ben
	j9dmp
	j9gc
	j9gcchk
	j9hookable
	j9jextract
	j9jnichk
	j9jvmti
	j9thr
	j9prt
	j9vm
	j9shr
	j9trc
	j9vrb
	jsig
	memorywatcher
	migration
	osmemory
	softmxtest
	vmruntimestateagent
	j9lazyClassLoad
	j9vmchk
	j9vmtest
	jclse7b_
	jclse9_
	jcoregen
	jlmagent
	j9ben
	jvm
	j9thrtestnatives
	PROPERTIES
	LINKER_LANGUAGE C
)

