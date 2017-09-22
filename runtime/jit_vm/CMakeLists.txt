
add_library(j9jit_vm STATIC
	artifact.c
	cthelpers.cpp
	ctsupport.c
)

target_include_directories(j9jit_vm
    PRIVATE
        ${PROJECT_SOURCE_DIR}/oti
        ${PROJECT_SOURCE_DIR}/include
        ${PROJECT_SOURCE_DIR}/gc_include
        ${PROJECT_SOURCE_DIR}/omr/include_core
        ${PROJECT_SOURCE_DIR}/codert_vm
)

target_link_libraries(j9jit_vm
  PRIVATE
    j9vm_compiler_defines
)
