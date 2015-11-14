# Insert content of the file at the top of all the files matching the mask in the directory
# @param dir - a directory to be scanned recursively
# @param mask - a search mask for the files
# @param file - a file to be inserted at the top of each file
# Example usage: include_foreach(include "*.h" copyright.txt)
function(include_foreach dir mask file)
	file(GLOB_RECURSE srcs "${dir}/${mask}")
	foreach(src ${srcs})
            file(READ ${file} file_content)
            file(READ ${src} src_content)

            string(FIND "${src_content}" "${file_content}" pos)

            if(${pos} EQUAL -1)
                set(tmp "${src}.tmp")
                configure_file(${file} ${tmp} COPYONLY)
                file(APPEND ${tmp} ${src_content})
                file(REMOVE ${src})
                configure_file(${tmp} ${src} COPYONLY)
                file(REMOVE ${tmp})
            endif()
	endforeach()
endfunction()

