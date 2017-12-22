/*[INCLUDE-IF Sidecar18-SE]*/
/*******************************************************************************
 * Copyright (c) 2007, 2017 IBM Corp. and others
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
package com.ibm.dtfj.javacore.parser.framework.scanner;

import java.io.IOException;
import java.util.ArrayList;

import com.ibm.dtfj.javacore.parser.framework.parser.ILookAheadBuffer;

public class LookAheadBuffer implements ILookAheadBuffer {
	private ArrayList fBuffer;
	private int fCurrentDepth;
	private IScanner fScanner;
	
	public LookAheadBuffer(int size, IScanner scanner) {
		fCurrentDepth = size;
		fBuffer = new ArrayList(fCurrentDepth);
		fScanner = scanner;
	}
	
	
	/**
	 * 
	 * @param tokenType
	 * 
	 */
	public boolean match(String tokenType) {
		boolean result = false;
		if (fBuffer.size() > 0) {
			IParserToken token = (IParserToken) fBuffer.get(0);
			if (token != null) {
				result = token.getType().equals(tokenType);
			}
			else {
				result = (tokenType == null);
			}
		}
		return result;
	}
	
	
	
	
	/**
	 * Consumes the first element in the buffer
	 * @throws ScannerException 
	 *
	 */
	public void consume() throws IOException, ScannerException {
		if (fBuffer.size() > 0) {
			fBuffer.remove(0);
		}
		fill();
		
	}
	
	
	/**
	 * 
	 * 
	 */
	public boolean allConsumed() {
		return fScanner.allTokensGenerated() && fBuffer.isEmpty() ;
	}
	
	
	
	/**
	 * 
	 * @throws ScannerException 
	 */
	private void fill() throws  IOException, ScannerException	{
		while (!fScanner.allTokensGenerated() && (fBuffer.size() < fCurrentDepth)) {
			IParserToken token = fScanner.next();
			fBuffer.add(token);	
		}
	}


	/**
	 * @throws ScannerException 
	 * @see com.ibm.dtfj.javacore.parser.framework.parser.ILookAheadBuffer#lookAhead(int)
	 */
	public IParserToken lookAhead(int depth) throws IOException, ScannerException, IndexOutOfBoundsException{
		fill();
		return (IParserToken)fBuffer.get(depth-1);
	}


	/**
	 * @throws ScannerException 
	 * 
	 */
	public void init() throws IOException, ScannerException {
		fill();
	}


	/**
	 * @throws ScannerException 
	 * @see com.ibm.dtfj.javacore.parser.framework.parser.ILookAheadBuffer#setLookAheadDepth(int)
	 */
	public void setLookAheadDepth(int depth) throws IOException, ScannerException {
		if (depth > 0){
			fCurrentDepth = depth;
			/*
			 * Fill any possible empty slots resulting from the buffer expansion.
			 * Nothing happens if the buffer remains the same or is reduced.
			 */
			fill();
		}
	}
	
	
	/**
	 * 
	 */
	public int length()	{
		return fBuffer.size();
	}
	
	public int maxDepth() {
		return fCurrentDepth;
	}
	
}
