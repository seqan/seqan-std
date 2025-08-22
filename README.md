<!--
SPDX-FileCopyrightText: 2006-2025 Knut Reinert & Freie Universität Berlin
SPDX-FileCopyrightText: 2016-2025 Knut Reinert & MPI für molekulare Genetik
SPDX-License-Identifier: CC-BY-4.0
-->

# seqan-std

Implementation of several C++23 views

## Quick start

### CMake with CPM

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=./test/CPM/CMakeLists.txt&syntax=cmake) -->
<!-- The below code snippet is automatically added from ./test/CPM/CMakeLists.txt -->
```cmake
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
```
<!-- MARKDOWN-AUTO-DOCS:END -->

### Example

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=./test/CPM/example.cpp) -->
<!-- The below code snippet is automatically added from ./test/CPM/example.cpp -->
```cpp
// SPDX-FileCopyrightText: 2006-2025 Knut Reinert & Freie Universität Berlin
// SPDX-FileCopyrightText: 2016-2025 Knut Reinert & MPI für molekulare Genetik
// SPDX-License-Identifier: CC0-1.0

#include <iostream>
#include <string_view>
#include <vector>

#include <seqan-std/enumerate_view.hpp>

int main()
{
    std::vector<std::string_view> vec{"Hello", "World", "!"};

    for (auto const [index, str] : seqan::stl::views::enumerate(vec))
        std::cout << index << ": " << str << '\n';
}
```
<!-- MARKDOWN-AUTO-DOCS:END -->

### Output

<!-- MARKDOWN-AUTO-DOCS:START (CODE:src=./test/CPM/example.expected&syntax=txt) -->
<!-- The below code snippet is automatically added from ./test/CPM/example.expected -->
```txt
0: Hello
1: World
2: !
```
<!-- MARKDOWN-AUTO-DOCS:END -->
