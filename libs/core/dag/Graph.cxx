// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Graph.h"

namespace pf::dag {
//-----------------------------------------------------------------------------
auto Graph::value() const -> int
{
  return _value;
}

//-----------------------------------------------------------------------------
auto Graph::my_method(Node& node) const -> int
{
  node.increment();
  return node.value() + _value;
}
}  // namespace pf::dag
