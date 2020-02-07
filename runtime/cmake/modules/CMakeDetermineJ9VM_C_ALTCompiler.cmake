################################################################################
# Copyright (c) 2020, 2020 IBM Corp. and others
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

#include(${CMAKE_ROOT}/Modules/CMakeDetermineCompiler.cmake)
set(CMAKE_J9VM_C_ALT_COMPILER_LIST clang)
#set(CMAKE_J9VM_C_ALT_COMPILER gcc-4.6)
set(CMAKE_J9VM_C_ALT_COMPILER_ENV_VAR J9ALTC)
#_cmake_find_compiler_path(J9VM_C_ALT)
find_program(CMAKE_J9VM_C_ALT_COMPILER "clang")

configure_file(${CMAKE_CURRENT_LIST_DIR}/CMakeJ9VM_C_ALTCompiler.cmake.in
${CMAKE_PLATFORM_INFO_DIR}/CMakeJ9VM_C_ALTCompiler.cmake @ONLY)


set(CMAKE_J9VM_C_ALT_DEFINE_FLAG -D)
set(CMAKE_INCLUDE_FLAG_J9VM_C_ALT -I)
set(CMAKE_J9VM_C_ALT_OUTPUT_EXTENSION .o)

set(CMAKE_J9VM_C_ALT_COMPILE_OBJECT "<CMAKE_J9VM_C_ALT_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT>  -c <SOURCE>")
