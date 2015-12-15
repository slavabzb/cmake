# Build docs

find_package(Doxygen)
if(DOXYGEN_FOUND)
	set(DOCS_SRC_DIR "${CMAKE_SOURCE_DIR}/docs")	# A directory where docs sources is located
	set(DOCS_OUT_DIR "${CMAKE_BINARY_DIR}/docs")	# A directory where generated docs will be placed
	set(DOCS_DIA_DIR "${DOCS_SRC_DIR}/dia")			# A directory where Dia diagram files (*.dia) is located
	set(DOCS_LOG_FILE "doxygen.log")				# A doxygen log file
	set(DOCS_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}") # A directory where docs will be installed
        set(DOCS_EXAMPLE_DIR "${CMAKE_SOURCE_DIR}/examples")
	set(DOCS_DIRS									# The directories to be scanned by doxygen
		"${TARGET_INCLUDE_PATH}/sgl/ \\
		${DOCS_SRC_DIR}")

	configure_file("${DOCS_SRC_DIR}/Doxyfile.in" "${CMAKE_BINARY_DIR}/Doxyfile")

	add_custom_target(docs ALL
		${CMAKE_COMMAND} -E make_directory ${DOCS_OUT_DIR}
		COMMAND doxygen
		COMMAND test -f "${CMAKE_BINARY_DIR}/${DOCS_LOG_FILE}" && echo "Error occurred while doxygen compiling documentation. Check ${DOCS_LOG_FILE}")

	install(DIRECTORY ${DOCS_OUT_DIR}
		DESTINATION ${DOCS_INSTALL_DIR}
		DIRECTORY_PERMISSIONS
			OWNER_EXECUTE OWNER_WRITE OWNER_READ
			GROUP_EXECUTE GROUP_READ
			WORLD_EXECUTE WORLD_READ
		FILE_PERMISSIONS
			OWNER_WRITE OWNER_READ
			GROUP_READ
			WORLD_READ)
endif()
