changequote(`[',`]')dnl
/*******************************************************************************
 * Licensed Materials - Property of IBM
 * "Restricted Materials of IBM"
 *
 * (c) Copyright IBM Corp. 2001, 2017 All Rights Reserved
 *
 * US Government Users Restricted Rights - Use, duplication or disclosure
 * restricted by GSA ADP Schedule Contract with IBM Corp.
 *******************************************************************************/
/* generated.c */
#ifdef WIN32
#include <windows.h>
#include <tchar.h>
#include <io.h>
#endif /* WIN32 */

#if defined(AIXPPC) || defined(J9ZOS390) || defined(LINUX)
#include <dlfcn.h>
#endif /* AIXPPC || J9ZOS390 || LINUX */


#include "j9.h"
#include "jni.h"

/* Avoid renaming malloc/free */
#define LAUNCHERS
#include "jvm.h"

#if defined(J9ZOS390)
#include <dll.h>
#include "atoe.h"
#include <stdlib.h>
#define dlsym   dllqueryfn
#define dlopen(a,b)     dllload(a)
#define dlclose dllfree
#endif

include(helpers.m4)

define([_IF],
[#if $1
$2
dnl #endif /* $1 */
#endif
])
dnl        (name,cc, decorate, ret, args..)

/* Manual typedefs for functions that can't be generated easily */
typedef int (*jio_fprintf_Type)(FILE * stream, const char * format, ...);
typedef int (*jio_snprintf_Type)(char * str, int n, const char * format, ...);
typedef void (JNICALL *JVM_OnExit_Type)(void (*func)(void));
 
/* Generated typedefs for all forwarded functions */
define([_X],
[typedef $4 ($2 *$1_Type)(join([, ],mshift(4,$@)));])dnl
include([forwarders.m4])
typedef void*  (JNICALL *JVM_LoadSystemLibrary_Type)(const char *libName);

/* Manually declared functions for non-generated forwarders */
static JVM_OnExit_Type global_JVM_OnExit;

/* Declare a static variable to hold each dynamically resolved function pointer. */
define([_X],[static $1_Type global_$1;])
include([forwarders.m4])


static volatile JVM_LoadSystemLibrary_Type global_JVM_LoadSystemLibrary;

#if defined(AIXPPC)
static int table_initialized = 0;

/* defined in redirector.c */
int openLibraries(const char *libraryDir);
#endif

int
jio_fprintf(FILE * stream, const char * format, ...)
{
	va_list args;
	int response = 0;
	va_start(args, format);
	response = jio_vfprintf(stream, format, args);
	va_end(args);
	return response;
}

int
jio_snprintf(char * str, int n, const char * format, ...)
{
	va_list args;
	int response = 0;
	va_start(args, format);
	response = jio_vsnprintf(str, n, format, args);
	va_end(args);
	return response;
}

void JNICALL
JVM_OnExit(void (*func)(void))
{
	if(global_JVM_OnExit != NULL) {
		global_JVM_OnExit( func );
	} else {
		exit(999); 
	}
}


dnl        (1-name,2-cc, 3-decorate, 4-ret, 5-args..)
define([_X],
[dnl
$4 $2
$1(join([, ],mshift(4,$@)))
{
	if(global_$1 != NULL) {
		invokePrefix($4)[]global_$1(arg_names_list(mshift(4,$@)));
#if defined(AIXPPC)
	} else if (!table_initialized) {
		/* attempt to open the 'master redirector' and try again */
		int openedLibraries = openLibraries("");
		if(JNI_ERR == openedLibraries) {
			fprintf(stdout, "Internal Error: Failed to initialize redirector - exiting\n");
			exit(998);
		}
		/* re-try to run this function */
		invokePrefix($4)[]$1(arg_names_list(mshift(4,$@)));
#endif
	} else {
		printf("Fatal Error: Missing forwarder for $1[]()");
		exit(969); 
	}
}
])
include([forwarders.m4])

static void *functionLookup(void *dllAddr, const char *functionName) {
#if defined(WIN32) && !defined(J9VM_ENV_DATA64)
	return GetProcAddress(dllAddr, functionName);
#else
	/* remove the decorations (leading _ and trailing @<number>) if present. */
#define J9_SYM_MAX 256
	char localFunctionName[[J9_SYM_MAX]];
	char *addrOfAtSymbol, *startOfFunctionName;

	if(strlen(functionName) >= J9_SYM_MAX) {
		printf("Symbol too long - %s - exiting\n", functionName);
	}

	startOfFunctionName = (char *) ((functionName[[0]] == '_') ? (functionName + 1) : functionName);

	addrOfAtSymbol = strchr(functionName, '@');
	if(addrOfAtSymbol) {
		memcpy(localFunctionName, startOfFunctionName, addrOfAtSymbol - startOfFunctionName);
		localFunctionName[[addrOfAtSymbol - startOfFunctionName]] = '\0';
	} else {
		strcpy(localFunctionName, functionName);
	}

#if defined(WIN32)
	/* this is actually for 64 bit windows only - ifdef above for win32 filtered 64 bit only down this path */
	return GetProcAddress(dllAddr, localFunctionName);
#else
	return (void *)dlsym(dllAddr, localFunctionName);
#endif

#endif
}
dnl        (1-name,2-cc, 3-decorate, 4-ret, 5-args..)

dnl ( 1-current_tally, 2-args....)
define([get_arg_size_impl],[])

define([type_is_ptr],[ifelse(index($1,[*]),[-1],[0],[1])])
define([type_is_wide],[ifelse($1,[jlong],[1],$1,[jdouble],1,0)])
define([get_arg_size_impl],[ifelse(type_is_ptr($1),[1],[4],type_is_wide($1),[1],[8],ifelse($1,[void],0,4))])
define([get_arg_size],[get_arg_size_impl(strip(get_arg_type($1)))])
define([get_function_arg_size_impl], [get_arg_size($1) ifelse(eval($# >= 2),[1],[+ get_function_arg_size_impl(shift($@))])])
define([get_function_arg_size], [eval(get_function_arg_size_impl($@))])

define([decorate_impl], [_$1@get_function_arg_size(mshift(4,$@))])
define([decorate_function_name], [ifelse($3,[true],decorate_impl($@),$1)])
define([_X],[	global_$1 = ($1_Type) functionLookup(vmdll, "decorate_function_name($@)" );])dnl

void lookupJVMFunctions(void *vmdll) {
	global_JVM_OnExit = (JVM_OnExit_Type) functionLookup(vmdll, "_JVM_OnExit@4" );
include([forwarders.m4])
	global_JVM_LoadSystemLibrary = (JVM_LoadSystemLibrary_Type) functionLookup(vmdll, "_JVM_LoadSystemLibrary@4" );
#if defined(AIXPPC)
	table_initialized = 1;
#endif
}

void*  JNICALL
JVM_LoadSystemLibrary(const char *libName)
{
	int count = 0;
	while ((NULL == global_JVM_LoadSystemLibrary) && (6000 != count)) {
#ifdef WIN32
		Sleep(5);	// 5ms
#else
		usleep(5000);	// 5ms
#endif		
		count++;
	}
	if(global_JVM_LoadSystemLibrary != NULL) {
		return global_JVM_LoadSystemLibrary( libName );
#if defined(AIXPPC)
	} else if (!table_initialized) {
		/* attempt to open the 'master redirector' and try again */
		int openedLibraries = openLibraries("");
		if(JNI_ERR == openedLibraries) {
			fprintf(stdout, "Internal Error: Failed to initialize redirector - exiting\n");
			exit(998);
		}
		/* re-try to run this function */
		return JVM_LoadSystemLibrary( libName );
#endif
	} else {
		printf("Fatal Error: Missing forwarder for JVM_LoadSystemLibrary()");
		exit(969); 
	}
}

/*
 * Following method JVM_InitAgentProperties() has been copied from actual JVM dll (implemented within \VM_Sidecar\j9vm\j7vmi.c) to 
 * this redirector dll. This is to address the issue identified by "RTC PR 104487: SVT:Eclipse:jdtdebug org.eclipse.core - 
 * Fails with Cannot load module libjvm.so file".
 *
 * This PR exposed that the JVM can be quite slow to finish lookupJVMFunctions() and complete the function table initialization such that 
 * a separated thread calling JVM_InitAgentProperties can fail with error "Cannot load module  libjvm.so file". 
 * Coping this method into redirector allows the call without finishing the function table initialization. 
 *      
 * The method is still kept within the actual jvm dll in case that a launcher uses that jvm dll directly without going through this redirector. 
 * If this method need to be modified, the changes have to be synchronized for both versions. 
 * 
 * The reason that this method can be copied into here (redirector) is that it doesn't require any other VM function support. 
 * As following comments, this method simply returns incoming agent_props to make the agent happy.
 * If there is a need in the future to modify this method and other VM function support are required, this method need to be moved back to JVM dll.
 * In such case, other means have to be developed to ensure this method still accessible in situations identified by PR 104487 mentioned above. 
 *   	 
 */

/*
 * com.sun.tools.attach.VirtualMachine support
 *
 * Initialize the agent properties with the properties maintained in the VM.
 * The following properties are apparently set by the Sun implementation:
 * 	sun.java.command = name of the main class
 *  sun.jvm.flags = vm arguments passed to the launcher
 *  sun.jvm.args =
 */
jobject JNICALL
JVM_InitAgentProperties(JNIEnv *env, jobject agent_props)
{
	/* CMVC 150259 : Assert in JDWP Agent
	 *   Simply returning the non-null properties instance is
	 *   sufficient to make the agent happy.  Do the simple
	 *   thing for now. */
	return agent_props;
}
