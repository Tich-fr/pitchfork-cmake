#include <pitchfork/Graph.h>
#include <pitchfork/Hidden.h>

#include <iostream>

int main(int /*argc*/, char** /*argv*/)
{
  pf::dag::Graph graph;
  pf::dag::Node node;
  pf::Hidden hidden;
  std::cout << "Graph::my_method:" << graph.my_method(node) << std::endl;
  std::cout << "Hidden::my_method:" << hidden.my_method() << std::endl;

  return 0;
}
