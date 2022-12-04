// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef pitchforkNode_h
#define pitchforkNode_h

namespace pf::dag {

/// @brief represent a node in a Directed Acyclic Graph (DAG).
///
/// This class is the main class for handling a node in a Directed Acyclig Graph (DAG).
/// (bla bla bla).
class Node {
public:
  /// @return Graph::_value
  [[nodiscard]] auto value() const -> int;

  /// @brief dummy method
  ///
  /// Increment by 1 the internal value of the current node
  void increment();

private:
  int _value = 1;  //< some useless integer value
};

}  // namespace pf::dag

#endif  // pitchforkNode_h
