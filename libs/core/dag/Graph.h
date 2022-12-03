// SPDX-FileCopyrightText: 2022 Timothee Chabat <timo.chabat@gmail.com>
// SPDX-License-Identifier: MIT

#ifndef pitchforkGraph_h
#define pitchforkGraph_h

#include "Node.h"

namespace pf::dag {

/// @brief represent a complete Directed Acyclic Graph (DAG).
///
/// This class is the main class for handling a Directed Acyclig Graph (DAG).
/// (bla bla bla).
class Graph {
public:

  /// @brief dummy method
  ///
  /// Increment the value of the given node and return
  /// the sum of its new value and the value of the graph.
  ///
  /// @param[out] node dummy output parameter
  /// @return Graph::value_ + node.value()
  int my_method(Node& node) const;

  /// @return Graph::value_
  [[nodiscard]] int value() const;

private:
  int value_ = 1;  //< some useless integer value
};

}  // namespace pf::dag

#endif  // pitchforkGraph_h
