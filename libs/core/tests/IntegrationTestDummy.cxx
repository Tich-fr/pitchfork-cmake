// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "pitchfork/Graph.h"
#include "pitchfork/Node.h"
#include "pitchfork/Point.h"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Dummy integration test for pf::core module", "[pf::core]")
{
    pf::dag::Graph graph;
    REQUIRE(graph.value() == 1);

    pf::dag::Node node;
    REQUIRE(graph.my_method(node) == 3);

    pf::Point point;
    REQUIRE(point.my_method() == 1);
}
