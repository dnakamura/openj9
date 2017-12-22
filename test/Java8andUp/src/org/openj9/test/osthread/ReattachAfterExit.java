/*******************************************************************************
 * Copyright (c) 2001, 2017 IBM Corp. and others
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
package org.openj9.test.osthread;

import org.testng.annotations.Test;
import org.testng.log4testng.Logger;
import org.testng.AssertJUnit;

public class ReattachAfterExit {
	public static final Logger logger = Logger.getLogger(ReattachAfterExit.class);

	private native boolean createTLSKeyDestructor();

	boolean threadOk;

	@Test(groups = { "level.sanity", "disabled.os.win" })
	public void testChildThread() throws InterruptedException, UnsatisfiedLinkError {
		System.loadLibrary("j9ben");
		Thread child = new Thread("child") {
			public void run() {
				threadOk = createTLSKeyDestructor();
			}
		};
		child.start();
		child.join(10 * 60 * 1000); /* wait 10 minutes */
		AssertJUnit.assertTrue("thread failed to create TLS key destructor", threadOk);
		AssertJUnit.assertTrue("Child thread should be dead.", !child.isAlive());
	}
}
