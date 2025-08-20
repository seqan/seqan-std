# SPDX-FileCopyrightText: 2006-2025 Knut Reinert & Freie Universität Berlin
# SPDX-FileCopyrightText: 2016-2025 Knut Reinert & MPI für molekulare Genetik
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required (VERSION 3.25)

project (SEQAN_STD
         LANGUAGES CXX
         VERSION 1.0.0
         DESCRIPTION "Implementation of several C++23/26 views"
)

get_filename_component (SEQAN_STD_DIR_NAME "${CMAKE_CURRENT_SOURCE_DIR}" NAME)
if (NOT SEQAN_STD_DIR_NAME STREQUAL "seqan-std")
    message (FATAL_ERROR "The directory name must be 'seqan-std'.")
endif ()

file (REAL_PATH "${CMAKE_CURRENT_SOURCE_DIR}/.." SEQAN_STD_INCLUDE_DIR)

add_library (seqan-std INTERFACE)
target_sources (seqan-std INTERFACE
    FILE_SET HEADERS
    TYPE HEADERS
    BASE_DIRS ${SEQAN_STD_INCLUDE_DIR}
    FILES
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/all_view.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/chunk_by_view.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/chunk_view.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/concepts.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/detail/adaptor_base.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/detail/adaptor_for_view_without_args.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/detail/adaptor_from_functor.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/detail/exposition_only.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/detail/movable_box.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/detail/non_propagating_cache.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/enumerate_view.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/join_with_view.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/pair.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/to.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/tuple.hpp
        ${SEQAN_STD_INCLUDE_DIR}/seqan-std/zip_view.hpp
)
target_compile_features (seqan-std INTERFACE cxx_std_20)
add_library (seqan::std ALIAS seqan-std)

option (SEQAN_STD_TEST "Enable testing for seqan-std." ${PROJECT_IS_TOP_LEVEL})

if (SEQAN_STD_TEST)
    enable_testing ()
    add_subdirectory (test)
endif ()
