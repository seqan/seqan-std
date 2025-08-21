# SPDX-FileCopyrightText: 2006-2025, Knut Reinert & Freie Universität Berlin
# SPDX-FileCopyrightText: 2016-2025, Knut Reinert & MPI für molekulare Genetik
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required (VERSION 3.25)

option (HEADER_FILE_ABSOLUTE "")
option (HEADER_FILE_INCLUDE "")
option (HEADER_TARGET_SOURCE "")
option (HEADER_SUB_TEST "")

file (WRITE "${HEADER_TARGET_SOURCE}" "") # write empty file

# cmake-format: off

if (HEADER_SUB_TEST STREQUAL "no-self-include")
    # this test ensures that a header will not be included by itself later
    file (READ "${HEADER_FILE_ABSOLUTE}" header_content)

    string (REGEX REPLACE "#[a-z]+ +(// +)?SEQAN_STD[A-Z_]+\n" "" header_content "${header_content}")

    file (APPEND "${HEADER_TARGET_SOURCE}"
        "// header-test-no-self-include-start\n"
        "${header_content}\n"
        "// header-test-no-self-include-end\n\n")
else ()
    # this test ensures that a header guard is in place
    file (APPEND "${HEADER_TARGET_SOURCE}"
          "// header-test-header-guard-start\n"
          "#include <${HEADER_FILE_INCLUDE}>\n"
          "#include <${HEADER_FILE_INCLUDE}>\n"
          "// header-test-header-guard-end\n\n")
endif ()

# cmake-format: on
