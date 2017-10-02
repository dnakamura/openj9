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
