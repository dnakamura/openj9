################################################################################
# Copyright (c) 1991, 2020 IBM Corp. and others
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

set(J9VM_ENV_DATA64 ON CACHE BOOL "")
# SSE detection is not needed, since is part of 64bit spec
set(J9VM_ENV_SSE2_SUPPORT_DETECTION OFF CACHE BOOL "")

set(J9VM_GC_ALIGN_OBJECTS OFF CACHE BOOL "")
set(J9VM_OPT_ZERO OFF CACHE BOOL "")

set(OMR_GC_IDLE_HEAP_MANAGER ON CACHE BOOL "")

include("${CMAKE_CURRENT_LIST_DIR}/linux_x86.cmake")
