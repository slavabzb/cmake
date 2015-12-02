# Build examples

set(EXAMPLES_SRC_DIR "${CMAKE_SOURCE_DIR}/examples")	# A directory where example subprojects is located
set(EXAMPLES_OUT_DIR "${CMAKE_BINARY_DIR}/examples")	# A directory where examples will be placed

file(MAKE_DIRECTORY ${EXAMPLES_OUT_DIR})

file(GLOB dirs "${EXAMPLES_SRC_DIR}/*")
foreach(dir ${dirs})
	if(IS_DIRECTORY ${dir})
		add_subdirectory(${dir})
	endif()
endforeach()