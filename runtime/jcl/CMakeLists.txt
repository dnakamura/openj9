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

add_subdirectory(cl_se7_basic)
add_subdirectory(cl_se9)
add_subdirectory(cl_se9_before_b165)

add_library(j9vm_jcl_includes INTERFACE)
#TODO this is platform specific
target_include_directories(j9vm_jcl_includes
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/unix
		${j9vm_SOURCE_DIR}/shared_common/include
)

add_library(j9vm_jcl_se6_vm-side_lifecycle INTERFACE)
target_sources(j9vm_jcl_se6_vm-side_lifecycle
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/vm_scar.c
)


add_library(j9vm_jcl_se6_vm-side_natives INTERFACE)
target_sources(j9vm_jcl_se6_vm-side_natives
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_J9VMInternals.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_ref_Finalizer.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_ref_Reference.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/common/reflecthelp.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/acccont.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/annparser.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jniidcacheinit.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/bootstrp.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/bpinit.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/clsldr.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/common/compiler.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/dump.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/exhelp
		${CMAKE_CURRENT_SOURCE_DIR}/common/getstacktrace
		${CMAKE_CURRENT_SOURCE_DIR}/common/iohelp.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jclcinit.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jcldefine.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jclexception.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jclglob.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jclhookhelp.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jclreflect.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/jclvm.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/log.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtclassloading.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtcompilation.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtgc.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtinit.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtmemmgr.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtmemory.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtmempool.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtos.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtosext.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtruntime.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtthread.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/proxy.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/shared.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/sigquit.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/stdinit
		${CMAKE_CURRENT_SOURCE_DIR}/common/system.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/string.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/thread.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/common/jcltrace.c
		#ut_j9jcl.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/vm_scar.c
		${CMAKE_CURRENT_SOURCE_DIR}/filesys/vmfilesys.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/vminternals.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/sun_reflect_ConstantPool.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_Class.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_Access.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/com_ibm_oti_vm_VM.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmthypervisor.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/mgmtprocessor.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/com_ibm_jvm_Stats.c

		#TODO platform specific stuff here
		${CMAKE_CURRENT_SOURCE_DIR}/unix/syshelp.c
)

j9vm_optional_compile(j9vm_jcl_se6_vm-side_natives
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/unix/helpers.c
)


target_include_directories(j9vm_jcl_se6_vm-side_natives
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common
		#TODO fix
		${CMAKE_CURRENT_SOURCE_DIR}/unix
)

add_library(j9vm_jcl_jithelpers INTERFACE)
target_sources(j9vm_jcl_jithelpers
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/jithelpers.c
		# <object name="zcipher">
			# <include-if condition="spec.zos_390.*"/>
		# </object>
		# <object name="zcipher_gcc">
			# <include-if condition="spec.linux_390.*"/>
		# </object>
)

j9vm_optional_compile(j9vm_jcl_jithelpers
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/crypto.c
)

add_library(j9vm_jcl_sun_misc_Unsafe INTERFACE)
target_sources(j9vm_jcl_sun_misc_Unsafe
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/sun_misc_Unsafe.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/common/unsafe_mem.c
)

add_library(j9vm_jcl_attach INTERFACE)
target_sources(j9vm_jcl_attach
	INTERFACE
	${CMAKE_CURRENT_SOURCE_DIR}/common/attach.c
)

add_library(j9vm_jcl_se7 INTERFACE)
target_sources(j9vm_jcl_se7
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_Access.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_Class.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/common/sun_misc_Perf.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/sun_reflect_ConstantPool.c
		#if spec.flags.opt_methodHandle
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_dyn_methodhandle.c
		#if spec.flags.opt_methodHandle
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_dyn_methodtype.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/extendedosmbean.c
)


add_library(j9vm_jcl_rcm INTERFACE)
target_sources(j9vm_jcl_rcm
	INTERFACE
		#${CMAKE_CURRENT_SOURCE_DIR}/common/rcmnatives.c
)

add_library(j9vm_jcl_se8 INTERFACE)
target_sources(j9vm_jcl_se8
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/gpu.c
)

add_library(j9vm_jcl_se9 INTERFACE)
target_sources(j9vm_jcl_se9
	INTERFACE
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_invoke_VarHandle.c
		${CMAKE_CURRENT_SOURCE_DIR}/common/java_lang_StackWalker.cpp
)
