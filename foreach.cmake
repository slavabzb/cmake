# Insert content of the file at the top for all the files matching the mask in the directory
# @param dir - a directory to be scanned recursively
# @param mask - a search mask for the files
# @param file - a file to be inserted at the top of each file
# Example usage: foreach_include(include "*.h" copyright.txt)
function(foreach_include dir mask file)
	file(GLOB_RECURSE srcs "${dir}/${mask}")
	foreach(src ${srcs})
            file(READ ${file} file_content)
            file(READ ${src} src_content)

            string(FIND "${src_content}" "${file_content}" pos)
            if(${pos} EQUAL -1)
                file(WRITE ${src} "${file_content}${src_content}")
            endif()
	endforeach()
endfunction()



# Removes content of the file from all the files matching the mask in the directory
# @param dir - a directory to be scanned recursively
# @param mask - a search mask for the files
# @param file - a file to be inserted at the top of each file
# Example usage: foreach_exclude(include "*.h" copyright.txt)
function(foreach_exclude dir mask file)
	file(GLOB_RECURSE srcs "${dir}/${mask}")
	foreach(src ${srcs})
            file(READ ${file} file_content)
            file(READ ${src} src_content)

            string(FIND "${src_content}" "${file_content}" pos)
            if(NOT ${pos} EQUAL -1)
                string(REPLACE "${file_content}" "" src_content "${src_content}")
                file(WRITE ${src} "${src_content}")
            endif()
	endforeach()
endfunction()
