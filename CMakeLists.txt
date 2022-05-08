project(Adagi DESCRIPTION "A Directed Acyclic Graph Interface")
cmake_minimum_required(VERSION 3.15)

# require C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(lib)

include(CTest)
if (BUILD_TESTING)
  add_subdirectory(test)
endif()