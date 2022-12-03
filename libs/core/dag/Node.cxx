// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Node.h"

namespace pf::dag {
//-----------------------------------------------------------------------------
int Node::value() const
{
  return _value;
}

//-----------------------------------------------------------------------------
void Node::increment()
{
  _value++;
}
}  // namespace pf::dag
