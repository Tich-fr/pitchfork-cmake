// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef pitchforkPoint_h
#define pitchforkPoint_h

namespace pf {

/// @brief represent a point in a 3D space
///
/// (bla bla bla)
class Point {
public:
  /// @return Point::_value
  [[nodiscard]] auto my_method() const -> int;

private:
  int _value = 1;
};
}  // namespace pf

#endif  // pitchforkPoint_h
