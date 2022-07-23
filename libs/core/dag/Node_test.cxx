#include "Node.h"

#include <iostream>

int Node_test(int /*argc*/, char** /*argv*/)
{
  int status = 0;

  pf::dag::Node node;
  int current_value = node.value();
  if (current_value != 1) {
    std::cerr << "ERROR: inital Node::value is wrong" << std::endl;
    status++;
  }

  node.increment();
  if (node.value() != (current_value + 1))
  {
    std::cerr << "ERROR: inital Node::increment did not increment" << std::endl;
    status++;
  }

  return status;
}
