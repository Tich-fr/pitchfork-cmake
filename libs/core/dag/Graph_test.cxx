#include "Graph.h"

#include <iostream>
#include "Node.h"

int Graph_test(int /*argc*/, char** /*argv*/)
{
  int status = 0;

  pf::dag::Graph graph;
  if (graph.value() != 1) {
    std::cerr << "ERROR: inital Graph::value is wrong" << std::endl;
    status++;
  }

  pf::dag::Node node;
  if (graph.my_method(node) != 3)
  {
    std::cerr << "ERROR: inital Graph::my_method is wrong" << std::endl;
    status++;
  }

  return status;
}
