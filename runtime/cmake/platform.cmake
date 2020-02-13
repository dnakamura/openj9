################################################################################
# Copyright (c) 2017, 2020 IBM Corp. and others
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
# SPDX-License-Identifier: EPL-2.0 OR Apache-2.0 OR GPL-2.0 WITH Classpath-exception-2.0 OR LicenseRef-GPL-2.0 WITH Assembly-exception
################################################################################

include(OmrPlatform)

#hack o3

if(OMR_TOOLCONFIG STREQUAL "gnu")
    list(APPEND OMR_PLATFORM_COMPILE_OPTIONS
        "-O3"
        "-fno-strict-aliasing"
        
    )
    list(APPEND OMR_PLATFORM_CXX_COMPILE_OPTIONS
        "-fno-rtti"
        "-fno-threadsafe-statics"
    )
    if(OMR_ARCH_S390)
        list(APPEND OMR_PLATFORM_COMPILE_OPTIONS
            "-mtune=z10"
            #"-march=z9-109" we get this from omr
            "-mzarch"
        )
    endif()
endif()

list(APPEND OMR_PLATFORM_DEFINITIONS
    -D_LONG_LONG
    -DJ9VM_TIERED_CODE_CACHE
    -DTR_HOST_S390
)
# Note: we need to inject WIN32 et al, as OMR no longer uses them
if(OMR_OS_WINDOWS)
    list(APPEND OMR_PLATFORM_DEFINITIONS
        -DWIN32
        -D_WIN32
    )
    if(OMR_ENV_DATA64)
        list(APPEND OMR_PLATFORM_DEFINITIONS
            -DWIN64
            -D_WIN64
        )
    endif()
endif()
omr_platform_global_setup()

if(OMR_TOOLCONFIG STREQUAL "gnu")
    set(CMAKE_CXX_FLAGS " -g -fno-exceptions ${CMAKE_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "-g ${CMAKE_C_FLAGS}")

    # Raise an error if a shared library has any unresolved symbols.
    # This flag isn't supported on OSX, but it has this behaviour by default
    if(NOT OMR_OS_OSX)
        set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-z,defs ${CMAKE_SHARED_LINKER_FLAGS}")
    endif()
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -fno-exceptions")
elseif(OMR_TOOLCONFIG STREQUAL "xlc")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -qalias=noansi")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -qalias=noansi -qnortti -qnoeh -qsuppress=1540-1087:1540-1088:1540-1090")
    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -qpic=large")
endif()

if(OMR_ARCH_POWER)
    #TODO do based on toolchain stuff
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        add_definitions(-DOMR_ENV_GCC)
    endif()
    #TODO this is a hack
    set(J9VM_JIT_RUNTIME_INSTRUMENTATION ON CACHE BOOL "")
    set(J9VM_PORT_RUNTIME_INSTRUMENTATION ON CACHE BOOL "")
endif()

if(OMR_OS_AIX)
    # Override cmake default of ".a" for shared libs on aix
    set(CMAKE_SHARED_LIBRARY_SUFFIX ".so")
endif()

if(NOT OMR_OS_OSX)
    add_definitions(-DIPv6_FUNCTION_SUPPORT)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fgnu89-inline -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1")

# Hook add_library and add_executable so that we can add rules to strip debug info
# on all targets.
# Note: when defining a function 'foo()' any existing definition of 'foo' gets mapped to '_foo'

function(add_library target)
    # Call the real add_library
    _add_library(${ARGV})

    # We only need to split debug info on shared libraries
    if("SHARED" IN_LIST ARGV)
        omr_split_debug("${target}")
    endif()
endfunction()

function(add_executable target)
    # Call the real add_executable
    _add_executable(${ARGV})

    omr_split_debug("${target}")
endfunction()
