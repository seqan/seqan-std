# SPDX-FileCopyrightText: 2006-2025 Knut Reinert & Freie Universität Berlin
# SPDX-FileCopyrightText: 2016-2025 Knut Reinert & MPI für molekulare Genetik
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required (VERSION 3.25)

project (SEQAN_STD
         LANGUAGES CXX
         VERSION 1.0.0
         DESCRIPTION "Implementation of several C++23/26 views"
)

if (TARGET seqan::std)
    return ()
endif ()

add_library (seqan-std INTERFACE)
target_sources (seqan-std INTERFACE
    FILE_SET HEADERS
    TYPE HEADERS
    BASE_DIRS ${PROJECT_SOURCE_DIR}/include
    FILES
        ${PROJECT_SOURCE_DIR}/include/seqan-std/all_view.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/chunk_by_view.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/chunk_view.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/concepts.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/detail/adaptor_base.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/detail/adaptor_for_view_without_args.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/detail/adaptor_from_functor.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/detail/exposition_only.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/detail/movable_box.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/detail/non_propagating_cache.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/enumerate_view.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/join_with_view.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/pair.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/to.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/tuple.hpp
        ${PROJECT_SOURCE_DIR}/include/seqan-std/zip_view.hpp
)
target_compile_features (seqan-std INTERFACE cxx_std_20)
add_library (seqan::std ALIAS seqan-std)

option (SEQAN_STD_TEST "Enable testing for seqan-std." ${PROJECT_IS_TOP_LEVEL})

if (SEQAN_STD_TEST)
    enable_testing ()
    add_subdirectory (test)
endif ()
