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

add_library(j9dyn_generic_test STATIC
    ../bcutil.c
    ../BufferManager.cpp
    ../cfreader.c
    ../ClassFileOracle.cpp
    ../ClassFileParser.cpp
    ../ClassFileWriter.cpp
    ../ComparingCursor.cpp
    ../ConstantPoolMap.cpp
    ../defineClass.c
    ../dynload.c
    ../J9PortAllocationStrategy.cpp
    ../jimageintf.c
    ../jsrinliner.c
    ../ROMClassBuilder.cpp
    ../ROMClassCreationContext.cpp
    ../ROMClassHashTable.c
    ../ROMClassSegmentAllocationStrategy.cpp
    ../ROMClassStringInternManager.cpp
    ../ROMClassWriter.cpp
    ../SRPKeyProducer.cpp
    ../SRPOffsetTable.cpp
    ../StringInternTable.cpp
    ../verifyerrstring.c
    ../WritingCursor.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/../../ut_jbcu.c
)

add_dependencies(j9dyn_generic_test j9dyn)
