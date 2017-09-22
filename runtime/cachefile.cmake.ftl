################################################################################
# Copyright (c) 1991, 2017 IBM Corp. and others
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

set(OMR_OPT_CUDA ${uma.spec.flags.opt_cuda.enabled?string("ON","OFF")} CACHE BOOL "")


set(OMR_GC_COMPRESSED_POINTERS ${uma.spec.flags.gc_compressedPointers.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_DYNAMIC_CLASS_UNLOADING ${uma.spec.flags.gc_dynamicClassUnloading.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_HYBRID_ARRAYLETS ${uma.spec.flags.gc_hybridArraylets.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_IDLE_HEAP_MANAGER ${uma.spec.flags.gc_idleHeapManager.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_LEAF_BITS ${uma.spec.flags.gc_leafBits.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_MODRON_COMPACTION ${uma.spec.flags.gc_modronCompaction.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_MODRON_CONCURRENT_MARK ${uma.spec.flags.gc_modronConcurrentMark.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_MODRON_SCAVENGER ${uma.spec.flags.gc_modronScavenger.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_REALTIME ${uma.spec.flags.gc_realtime.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_SEGREGATED_HEAP ${uma.spec.flags.gc_segregatedHeap.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_STACCATO ${uma.spec.flags.gc_staccato.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_TLH_PREFETCH_FTA ${uma.spec.flags.gc_tlhPrefetchFTA.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_GC_VLHGC ${uma.spec.flags.gc_vlhgc.enabled?string("ON","OFF")} CACHE BOOL "")

set(OMR_INTERP_COMPRESSED_OBJECT_HEADER ${uma.spec.flags.interp_compressedObjectHeader.enabled?string("ON","OFF")} CACHE BOOL "")
set(OMR_INTERP_SMALL_MONITOR_SLOT ${uma.spec.flags.interp_smallMonitorSlot.enabled?string("ON","OFF")} CACHE BOOL "")

set(J9VM_PORT_RUNTIME_INSTRUMENTATION ${uma.spec.flags.port_runtimeInstrumentation.enabled?string("ON","OFF")} CACHE BOOL "")

#TODO these options to be properly configured like the rest
set(OMR_GC_ARRAYLETS ON CACHE BOOL "")
set(OMR_GC_CONCURRENT_SWEEP ON CACHE BOOL "")
set(OMR_PORT_ASYNC_HANDLER ON CACHE BOOL "")
set(OMR_PORT_CAN_RESERVE_SPECIFIC_ADDRESS ON CACHE BOOL "")
set(OMR_PORT_NUMA_SUPPORT ON CACHE BOOL "")
set(OMR_THR_JLM ON CACHE BOOL "")
set(OMR_THR_YIELD_ALG ON CACHE BOOL "")
set(OMR_THR_SPIN_WAKE_CONTROL ON CACHE BOOL "")
set(OMR_THR_CUSTOM_SPIN_OPTIONS ON CACHE BOOL "")
set(OMR_NOTIFY_POLICY_CONTROL ON CACHE BOOL "")
set(OMR_THR_THREE_TIER_LOCKING ON CACHE BOOL "")
set(J9VM_OPT_MEMORY_CHECK_SUPPORT ON CACHE BOOL "")
set(J9VM_OPT_REMOTE_CONSOLE_SUPPORT ON CACHE BOOL "")
set(J9VM_GC_VLHGC ON CACHE BOOL "")


set(J9VM_MODULE_JEXTRACTNATIVES ${uma.spec.flags.module_jextractnatives.enabled?string("ON","OFF")} CACHE BOOL "")

set(J9VM_MODULE_ALGORITHM_TEST ${uma.spec.flags.module_algorithm_test.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_BCUTIL ${uma.spec.flags.module_bcutil.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_BCVERIFY ${uma.spec.flags.module_bcverify.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CALLCONV ${uma.spec.flags.module_callconv.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CASSUME ${uma.spec.flags.module_cassume.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CFDUMPER ${uma.spec.flags.module_cfdumper.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CODEGEN_COMMON ${uma.spec.flags.module_codegen_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CODEGEN_IA32 ${uma.spec.flags.module_codegen_ia32.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CODEGEN_ILGEN ${uma.spec.flags.module_codegen_ilgen.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CODEGEN_OPT ${uma.spec.flags.module_codegen_opt.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CODERT_COMMON ${uma.spec.flags.module_codert_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CODERT_IA32 ${uma.spec.flags.module_codert_ia32.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CODERT_VM ${uma.spec.flags.module_codert_vm.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CPO_COMMON ${uma.spec.flags.module_cpo_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_CPO_CONTROLLER ${uma.spec.flags.module_cpo_controller.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_DBGEXT ${uma.spec.flags.module_dbgext.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_DBGINFOSERV ${uma.spec.flags.module_dbginfoserv.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_DDR ${uma.spec.flags.module_ddr.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_EXE ${uma.spec.flags.module_exe.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_EXELIB ${uma.spec.flags.module_exelib.enabled?string("ON","OFF")} CACHE BOOL "")


#<flag id="module_exe.j9" value="true"/>

set(J9VM_MODULE_GC ${uma.spec.flags.module_gc.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_API ${uma.spec.flags.module_gc_api.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_BASE ${uma.spec.flags.module_gc_base.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_CHECK ${uma.spec.flags.module_gc_check.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_COMMON ${uma.spec.flags.module_gc_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_MODRON_BASE ${uma.spec.flags.module_gc_modron_base.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_MODRON_EPROF ${uma.spec.flags.module_gc_modron_eprof.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_MODRON_STANDARD ${uma.spec.flags.module_gc_modron_standard.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_MODRON_STARTUP ${uma.spec.flags.module_gc_modron_startup.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_REALTIME ${uma.spec.flags.module_gc_realtime.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_STACCATO ${uma.spec.flags.module_gc_staccato.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_STATS ${uma.spec.flags.module_gc_stats.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_STRUCTS ${uma.spec.flags.module_gc_structs.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_TRACE ${uma.spec.flags.module_gc_trace.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_UTIL ${uma.spec.flags.module_gc_util.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GC_UTIL ${uma.spec.flags.module_gc_util.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GCCHK ${uma.spec.flags.module_gcchk.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GDB ${uma.spec.flags.module_gdb.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GDB_PLUGIN ${uma.spec.flags.module_gdb_plugin.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_GPTEST ${uma.spec.flags.module_gptest.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_J9VM ${uma.spec.flags.module_j9vm.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_J9VMTEST ${uma.spec.flags.module_j9vmtest.enabled?string("ON","OFF")} CACHE BOOL "")


#<flag id="module_jcl.profile_scar" value="true"/>
#<flag id="module_jcl.scar" value="true"/>

set(J9VM_MODULE_JEXTRACTNATIVES ${uma.spec.flags.module_jextractnatives.enabled?string("ON","OFF")} CACHE BOOL "")

set(J9VM_MODULE_JIT_COMMON ${uma.spec.flags.module_jit_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JIT_IA32 ${uma.spec.flags.module_jit_ia32.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JIT_VM ${uma.spec.flags.module_jit_vm.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JITDEBUG_COMMON ${uma.spec.flags.module_jitdebug_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JITRT_COMMON ${uma.spec.flags.module_jitrt_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JITRT_IA32 ${uma.spec.flags.module_jitrt_ia32.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JNIARGTESTS ${uma.spec.flags.module_jniargtests.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JNICHK ${uma.spec.flags.module_jnichk.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JNIINV ${uma.spec.flags.module_jniinv.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JNITEST ${uma.spec.flags.module_jnitest.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JSIG ${uma.spec.flags.module_jsig.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JVMTI ${uma.spec.flags.module_jvmti.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_JVMTITST ${uma.spec.flags.module_jvmtitst.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_LIFECYCLE_TESTS ${uma.spec.flags.module_lifecycle_tests.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_MASM2GAS ${uma.spec.flags.module_masm2gas.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_MVMTEST ${uma.spec.flags.module_mvmtest.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_PORTTEST ${uma.spec.flags.module_porttest.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_RASDUMP ${uma.spec.flags.module_rasdump.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_RASTRACE ${uma.spec.flags.module_rastrace.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_SHARED ${uma.spec.flags.module_shared.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_SHARED_COMMON ${uma.spec.flags.module_shared_common.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_SHARED_TEST ${uma.spec.flags.module_shared_test.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_SHARED_UTIL ${uma.spec.flags.module_shared_util.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_UTE ${uma.spec.flags.module_ute.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_UTETEST ${uma.spec.flags.module_utetst.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_VERBOSE ${uma.spec.flags.module_verbose.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_VMALL ${uma.spec.flags.module_vmall.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_ZIP ${uma.spec.flags.module_zip.enabled?string("ON","OFF")} CACHE BOOL "")
set(J9VM_MODULE_ZLIB ${uma.spec.flags.module_zlib.enabled?string("ON","OFF")} CACHE BOOL "")

set(CMAKE_C_COMPILER ${uma.spec.properties.uma_make_cmd_cc.value} CACHE STRING "")

<#if uma.spec.properties.uma_make_cmd_cxx.value == "$(CC)">
set(CMAKE_CXX_COMPILER ${uma.spec.properties.uma_make_cmd_cc.value} CACHE STRING "")
<#else >
set(CMAKE_CXX_COMPILER ${uma.spec.properties.uma_make_cmd_cxx.value} CACHE STRING "")
</#if>

#for weird platforms where we compile C with the C++ compiler
<#if uma.spec.properties.uma_make_cmd_cxx_dll_ld.value == "$(CC)">
set(CMAKE_C_CREATE_SHARED_LIBRARY "${uma.spec.properties.uma_make_cmd_cc.value} <CMAKE_SHARED_LIBRARY_C_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS> <SONAME_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>" CACHE STRING "")
<#else >
set(CMAKE_C_CREATE_SHARED_LIBRARY "${uma.spec.properties.uma_make_cmd_cxx_dll_ld.value} <CMAKE_SHARED_LIBRARY_C_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS> <SONAME_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>" CACHE STRING "")
</#if>

#Prefer the C linker
set(CMAKE_C_LINKER_PREFERENCE 10 CACHE STRING "")
set(CMAKE_CXX_LINKER_PREFERENCE 1 CACHE STRING "")
