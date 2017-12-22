/*******************************************************************************
 * Copyright (c) 2001, 2014 IBM Corp. and others
 *
 * This program and the accompanying materials are made available under
 * the terms of the Eclipse Public License 2.0 which accompanies this
 * distribution and is available at https://www.eclipse.org/legal/epl-2.0/
 * or the Apache License, Version 2.0 which accompanies this distribution and
 * is available at https://www.apache.org/licenses/LICENSE-2.0.
 *
 * This Source Code may also be made available under the following
 * Secondary Licenses when the conditions for such availability set
 * forth in the Eclipse Public License, v. 2.0 are satisfied: GNU
 * General Public License, version 2 with the GNU Classpath
 * Exception [1] and GNU General Public License, version 2 with the
 * OpenJDK Assembly Exception [2].
 *
 * [1] https://www.gnu.org/software/classpath/license.html
 * [2] http://openjdk.java.net/legal/assembly-exception.html
 *
 * SPDX-License-Identifier: EPL-2.0 OR Apache-2.0 OR GPL-2.0 WITH Classpath-exception-2.0 OR LicenseRef-GPL-2.0 WITH Assembly-exception
 *******************************************************************************/
package com.ibm.j9ddr.view.dtfj.test;

import static org.junit.Assert.fail;

import java.util.List;

import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import com.ibm.dtfj.java.JavaRuntime;

public class JavaVMOptionTest extends DTFJUnitTest {

	@BeforeClass
	public static void classSetup() {
		init();
	}
	
	@Before
	public void setup() {
		initTestObjects();
	}
	
	protected void loadTestObjects(JavaRuntime ddrRuntime, List<Object> ddrObjects, JavaRuntime jextractRuntime, List<Object> jextractObjects) {
		try {
			fillLists(ddrObjects, ddrRuntime.getJavaVMInitArgs().getOptions(), jextractObjects, jextractRuntime.getJavaVMInitArgs().getOptions(), null);
		} catch (Exception e) {
			fail("Error getting VM options : " + e.getMessage());
		}
	}
	
	@Test
	public void getExtraInfoTest() {
		imagePointerComparator.testComparatorEquals(ddrTestObjects, jextractTestObjects, "getExtraInfo");
	}
	
	@Test
	public void getOptionStringTest() {
		javaVMOptionComparator.testJavaEquals(ddrTestObjects, jextractTestObjects, "getOptionString");
	}
}
