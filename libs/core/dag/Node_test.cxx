#include "Node.h"

#include <catch2/catch_session.hpp>
#include <catch2/catch_test_macros.hpp>

TEST_CASE("Dummy Node test", "[pf::dag::Node]")
{
    pf::dag::Node node;
    REQUIRE(node.value() == 1);

    node.increment();
    REQUIRE(node.value() == 2);
}

int Node_test(int argc, char** argv)
{
  return Catch::Session().run( argc, argv );
}
