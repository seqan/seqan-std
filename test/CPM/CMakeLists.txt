# SPDX-FileCopyrightText: 2006-2025 Knut Reinert & Freie Universität Berlin
# SPDX-FileCopyrightText: 2016-2025 Knut Reinert & MPI für molekulare Genetik
# SPDX-License-Identifier: CC0-1.0

cmake_minimum_required (VERSION 3.25)

project (example
         LANGUAGES CXX)

# CPM Documentation:
#   Adding CPM: https://github.com/cpm-cmake/CPM.cmake?tab=readme-ov-file#adding-cpm
#   Example : https://github.com/cpm-cmake/CPM.cmake?tab=readme-ov-file#full-cmakelists-example
# For CPM's example, "${CPM_FILE}" would be "cmake/CPM.cmake"
include (${CPM_FILE})
CPMAddPackage ("gh:seqan/seqan-std#main")

add_executable (example example.cpp)
target_link_libraries (example seqan::std)
