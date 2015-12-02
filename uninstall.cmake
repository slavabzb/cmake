# Removes all the files listed in install_manifest.txt

set(MANIFEST "${CMAKE_BINARY_DIR}/install_manifest.txt")

if(NOT EXISTS ${MANIFEST})
    message(FATAL_ERROR "Cannot find install manifest: ${MANIFEST}")
endif()

file(STRINGS ${MANIFEST} files)
foreach(file ${files})
    if(EXISTS ${file})
        message(STATUS "Removing: ${file}")

        exec_program(
            ${CMAKE_COMMAND} ARGS "-E remove ${file}"
            OUTPUT_VARIABLE stdout
            RETURN_VALUE result
        )

        if(NOT "${result}" STREQUAL 0)
            message(WARNING "Failed to remove file: ${file}.")
        endif()
    endif()
endforeach(file)
