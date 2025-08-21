# SPDX-FileCopyrightText: 2006-2025, Knut Reinert & Freie Universität Berlin
# SPDX-FileCopyrightText: 2016-2025, Knut Reinert & MPI für molekulare Genetik
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required (VERSION 3.25)

################################################################################
################################# Header Test ##################################
################################################################################
option (SEQAN_STD_WITH_WERROR "Report compiler warnings as errors." ON)

add_library (seqan-std_test INTERFACE)
target_link_libraries (seqan-std_test INTERFACE seqan::std)
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    target_compile_options (seqan-std_test INTERFACE "-pedantic" "-Wall" "-Wextra")
    if (SEQAN_STD_WITH_WERROR)
        target_compile_options (seqan-std_test INTERFACE "-Werror")
        message (STATUS "Building tests with -Werror.")
    endif ()
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 14)
        target_compile_options (seqan-std_test INTERFACE "-Wnrvo")
    endif ()
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    target_compile_options (seqan-std_test INTERFACE "/W4")
    if (SEQAN_STD_WITH_WERROR)
        target_compile_options (seqan-std_test INTERFACE "/WX")
        message (STATUS "Building tests with /WX.")
    endif ()
endif ()

get_target_property (header_files seqan-std HEADER_SET_HEADERS)
get_target_property (include_dir seqan-std HEADER_DIRS)

# Generate a file that includes all headers (check for wrong include guards) and a `main` function (linking).
# Strip ${include_dir} from absolute include paths:
# "/home/user/develop/seqan-std/include/seqan-std/all_view.hpp" -> "seqan-std/all_view.hpp"
set (generator_relative_path "$<PATH:RELATIVE_PATH,${header_files},${include_dir}>")
# For each list item, prepend with "#include <"
# "seqan-std/all_view.hpp" -> "#include <seqan-std/all_view.hpp"
set (generator_prepend_include "$<LIST:TRANSFORM,${generator_relative_path},PREPEND,#include \<>")
# Join the list, use ">\n" as separator. "$<ANGLE-R>" must be used for ">"
# "#include <seqan-std/all_view.hpp" -> "#include <seqan-std/all_view.hpp>"
set (generator_join_list "$<JOIN:${generator_prepend_include},$<ANGLE-R>\n>")
# Generate file. The last item in the list is missing ">", so we add another ">".
file (GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/header_test.cpp"
      CONTENT "${generator_join_list}$<ANGLE-R>\n\nint main() { return 0; }")
add_executable (header_test ${CMAKE_CURRENT_BINARY_DIR}/header_test.cpp)
target_link_libraries (header_test seqan-std_test)
add_test (NAME "header_test" COMMAND header_test)

foreach (absolute_header_path ${header_files})
    file (RELATIVE_PATH header "${include_dir}" "${absolute_header_path}")
    get_filename_component (header_test_name "${absolute_header_path}" NAME_WE)

    foreach (header_sub_test "header-guard" "no-self-include")
        set (header_target "${header_test_name}-${header_sub_test}")
        set (header_target_source "${CMAKE_CURRENT_BINARY_DIR}/header_test_files/${header_target}.cpp")

        # we use add_custom_command to detect changes to a header file, which will update the generated source file
        add_custom_command (OUTPUT "${header_target_source}"
                            COMMAND "${CMAKE_COMMAND}" #
                                    "-DHEADER_FILE_ABSOLUTE=${absolute_header_path}"
                                    "-DHEADER_FILE_INCLUDE=${header}"
                                    "-DHEADER_TARGET_SOURCE=${header_target_source}"
                                    "-DHEADER_SUB_TEST=${header_sub_test}" #
                                    "-P" "${CMAKE_CURRENT_SOURCE_DIR}/generate_header_source.cmake"
                            DEPENDS "${absolute_header_path}"
                                    "${CMAKE_CURRENT_SOURCE_DIR}/generate_header_source.cmake")

        add_library (${header_target} OBJECT "${header_target_source}")
        target_link_libraries (${header_target} seqan-std_test)
        target_sources (header_test PRIVATE $<TARGET_OBJECTS:${header_target}>)
    endforeach ()
endforeach ()

################################################################################
############################ FILE_SET HEADERS check ############################
################################################################################
add_test (NAME "file_set_check"
          COMMAND ${CMAKE_COMMAND} "-DHEADER_SET=$<JOIN:${header_files},;>"
                                   "-DINCLUDE_DIRECTORY=${include_dir}"
                                   -P "${CMAKE_CURRENT_SOURCE_DIR}/check_file_set.cmake")

set_tests_properties (header_test PROPERTIES DEPENDS file_set_check)
