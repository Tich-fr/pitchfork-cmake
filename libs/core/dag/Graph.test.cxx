// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Graph.h"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Dummy Graph test", "[pf::dag::Graph]")
{
  pf::dag::Graph graph_val;
  REQUIRE(graph_val.value() == 1);
}
