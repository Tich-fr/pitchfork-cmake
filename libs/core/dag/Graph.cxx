// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Graph.h"

namespace pf::dag {
//-----------------------------------------------------------------------------
int Graph::value() const
{
  return _value;
}

//-----------------------------------------------------------------------------
int Graph::my_method(Node& node) const
{
  node.increment();
  return node.value() + _value;
}
}  // namespace pf::dag
