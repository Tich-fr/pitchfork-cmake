// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef pitchforkHidden_h
#define pitchforkHidden_h

namespace pf {

/// @brief Some class in an optional module
///
/// (bla bla bla)
class Hidden {
public:

  /// @return Hidden::value_
  [[nodiscard]] int my_method() const;

private:
  int value_ = 1;
};
}  // namespace pf

#endif  // pitchforkHidden_h
