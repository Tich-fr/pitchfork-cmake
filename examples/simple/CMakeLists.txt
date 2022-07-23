cmake_minimum_required(VERSION 3.18)
project(SimplePitchforkExample LANGUAGES CXX)

# If example is not built from the pitchfork toplevel CMakeLists then try to look for the library
get_property(top_level DIRECTORY PROPERTY PARENT_DIRECTORY)
if(NOT top_level)
  find_package(pitchfork REQUIRED CONFIG COMPONENTS Core Opt)
endif()

add_executable(${PROJECT_NAME} main.cxx)

target_link_libraries(${PROJECT_NAME} pitchfork::core pitchfork::opt)
