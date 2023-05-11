# Simple project setup
cmake_minimum_required(VERSION 3.19)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/tools/cmake")

project(pitchfork
  LANGUAGES CXX
  DESCRIPTION "A CMake Implementation Of The Pitchfork Layout"
  VERSION 0.0.1)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# include standard cmake capabilities
include(GNUInstallDirs)
include(CTest)

# project-wide settings
include(pfClangTidy)         # pitchfork_TOOL_ENABLE_CLANG_TIDY
include(pfIWYU)              # pitchfork_TOOL_ENABLE_IWYU
include(pfLWYU)              # pitchfork_TOOL_ENABLE_LWYU
include(pfSanitizers)        # pitchfork_TOOL_ENABLE_SANITIZERS
option(BUILD_SHARED_LIBS "Build libraries as shared libraries by default." ON)
option(BUILD_DOCUMENTATION "Build documentation tree" OFF)
option(BUILD_EXAMPLES "Build examples tree" OFF)

# build sources
add_subdirectory(external)
add_subdirectory(libs)
add_subdirectory(extras)

if(BUILD_DOCUMENTATION)
  add_subdirectory(docs)
endif()

if(BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()

# Configuration files and installation
# Configuration is done via the `tools/cmake/config.cmake.in` file
include(CMakePackageConfigHelpers)
configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/tools/cmake/config.cmake.in" "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION
    "${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}"
  )

write_basic_package_version_file("${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}ConfigVersion.cmake"
  VERSION "${CMAKE_PROJECT_VERSION}"
  COMPATIBILITY SameMajorVersion
  )

install(
  FILES
    "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}Config.cmake"
    "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}ConfigVersion.cmake"
  DESTINATION
    "${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}"
  COMPONENT
    ${CMAKE_PROJECT_NAME}_Devel
  )

# Packaging
# Configuration is done via the `tools/cmake/cpack.cmake.in` file
include(CPack)
configure_file("tools/cmake/cpack.cmake.in" "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}CPackOptions.cmake"
  @ONLY)
set (CPACK_PROJECT_CONFIG_FILE "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}CPackOptions.cmake")
