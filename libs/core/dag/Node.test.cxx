// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Node.h"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Dummy Node test", "[pf::dag::Node]")
{
  pf::dag::Node node;
  REQUIRE(node.value() == 1);

  node.increment();
  REQUIRE(node.value() == 2);
}
