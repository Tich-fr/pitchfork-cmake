# Simple project setup
cmake_minimum_required(VERSION 3.18)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/tools/cmake")

project(pitchfork
  LANGUAGES CXX
  DESCRIPTION "A CMake Implementation Of The Pitchfork Layout"
  VERSION 0.0.1)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(GNUInstallDirs)
set(pitchfork_bin_includedir "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}")

# Handle sub directories
include(CTest)
add_subdirectory(libs)

option(BUILD_DOCUMENTATION "Build documentation tree" OFF)
if(BUILD_DOCUMENTATION)
  add_subdirectory(docs)
endif()

option(BUILD_EXAMPLES "Build examples tree" OFF)
if(BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

# Packaging
# Configuration is done via the `tools/cmake/cpack.cmake.in` file
include(CPack)
configure_file("tools/cmake/cpack.cmake.in" "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}CPackOptions.cmake"
  @ONLY)
set (CPACK_PROJECT_CONFIG_FILE "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}CPackOptions.cmake")
