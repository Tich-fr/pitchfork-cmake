// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#include "Hidden.h"

namespace pf {
//-----------------------------------------------------------------------------
auto Hidden::my_method() const -> int
{
  return _value;
}
}  // namespace pf
