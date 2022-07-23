#include "Node.h"

namespace pf::dag {
//-----------------------------------------------------------------------------
int Node::value() const
{
  return this->value_;
}

//-----------------------------------------------------------------------------
void Node::increment()
{
  this->value_++;
}
}  // namespace pf::dag
