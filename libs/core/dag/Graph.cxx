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
