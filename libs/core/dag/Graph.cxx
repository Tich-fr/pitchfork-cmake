// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Graph.h"

namespace pf::dag {
//-----------------------------------------------------------------------------
int Graph::value() const
{
  return this->value_;
}

//-----------------------------------------------------------------------------
int Graph::my_method(Node& node) const
{
  node.increment();
  return node.value() + this->value_;
}
}  // namespace pf::dag
