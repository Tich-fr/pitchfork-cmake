#include "Graph.h"
#include "Node.h"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Dummy Graph test", "[pf::dag::Graph]")
{
    pf::dag::Graph graph;
    REQUIRE(graph.value() == 1);

    pf::dag::Node node;
    REQUIRE(graph.my_method(node) == 3);
}
