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
