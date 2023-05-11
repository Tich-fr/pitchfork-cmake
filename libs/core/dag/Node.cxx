// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Node.h"

namespace pf::dag {
//-----------------------------------------------------------------------------
auto Node::value() const -> int
{
  int toto = _value;
  return toto;
}

//-----------------------------------------------------------------------------
void Node::increment()
{
  _value++;
}
}  // namespace pf::dag
