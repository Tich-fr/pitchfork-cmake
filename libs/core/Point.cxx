// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Point.h"
#include <pitchfork/Node.h>

namespace pf {
//-----------------------------------------------------------------------------
auto Point::my_method() const -> int
{
  return Value;
}
}  // namespace pf
