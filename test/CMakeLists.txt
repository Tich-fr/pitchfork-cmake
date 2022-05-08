add_executable(TestGraph TestGraph.cxx)
target_link_libraries(TestGraph PRIVATE Adagio::Core)
add_test(NAME TestGraph COMMAND TestGraph)