# Build tests

find_package(CxxTest)
if(CXXTEST_FOUND)
	set(CXXTEST_SRC_DIR "tests")					# A directory where the cxxtest sources (*.h) is located
	set(CXXTEST_OUT_DIR "tests")					# A directory where the cxxtest output will be placed
	set(CXXTEST_GEN_DIR "${CXXTEST_OUT_DIR}/src")	# A directory where the generated test sources (*.cpp) will be placed
	set(CXXTEST_BIN_DIR "${CXXTEST_OUT_DIR}/bin")	# A directory where the test binaries will be placed

	set(CXXTEST_LINK_LIBS ${PROJECT_NAME})			# The libraries will be linked to the test binaries

	include_directories(${CXXTEST_INCLUDE_DIR})
	enable_testing()

	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${CXXTEST_OUT_DIR}")
	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${CXXTEST_GEN_DIR}")
	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${CXXTEST_BIN_DIR}")

	set(EXECUTABLE_OUTPUT_PATH ${CXXTEST_BIN_DIR})

	file(GLOB_RECURSE src_list "${CXXTEST_SRC_DIR}/*.h")
	foreach(src ${src_list})
		get_filename_component(test_name ${src} NAME_WE)
		set(test_gen_src "${CXXTEST_GEN_DIR}/${test_name}.cpp")
		cxxtest_add_test(${test_name} ${test_gen_src} ${src})
		target_link_libraries(${test_name} ${CXXTEST_LINK_LIBS})
	endforeach()
endif()
