# SPDX-FileCopyrightText: 2006-2025, Knut Reinert & Freie Universität Berlin
# SPDX-FileCopyrightText: 2016-2025, Knut Reinert & MPI für molekulare Genetik
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required (VERSION 3.25)

option (INCLUDE_DIRECTORY "")
option (HEADER_SET "")

if (NOT INCLUDE_DIRECTORY)
    message (FATAL_ERROR "INCLUDE_DIRECTORY must be set.")
endif ()
if (NOT HEADER_SET)
    message (FATAL_ERROR "HEADER_SET must be set.")
endif ()

file (GLOB_RECURSE header_files
      LIST_DIRECTORIES FALSE
      "${INCLUDE_DIRECTORY}/*")

foreach (header_file IN LISTS header_files)
    if (NOT header_file IN_LIST HEADER_SET)
        list (APPEND missing_headers "${header_file}")
    endif ()
endforeach ()

foreach (header_file IN LISTS HEADER_SET)
    if (NOT header_file IN_LIST header_files)
        list (APPEND non_existing_headers "${header_file}")
    endif ()
endforeach ()

if (missing_headers)
    string (REPLACE ";" " " missing_headers "${missing_headers}")
    set (error_message "Missing from FILE_SET HEADERS: ${missing_headers}\n")
endif ()

if (non_existing_headers)
    string (REPLACE ";" " " non_existing_headers "${non_existing_headers}")
    set (error_message "${error_message}Non-existing headers in FILE_SET HEADERS: ${non_existing_headers}")
endif ()

if (error_message)
    message (FATAL_ERROR "${error_message}")
endif ()
