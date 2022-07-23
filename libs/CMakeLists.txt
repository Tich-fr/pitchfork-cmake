include(ModuleHelpers)

# Include all submodules and optional submodules
add_subdirectory(core)

option(pitchfork_MODULE_ENABLE_OPT "Enable the opt module" ON)
if (pitchfork_MODULE_ENABLE_OPT)
  add_subdirectory(opt)
endif()

# Configuration files and installation
# Configuration is done via the `tools/cmake/config.cmake.in` file
include(CMakePackageConfigHelpers)
configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/tools/cmake/config.cmake.in" "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION
    "${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}"
  )

write_basic_package_version_file(
  "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}ConfigVersion.cmake"
  VERSION "${CMAKE_PROJECT_VERSION}"
  COMPATIBILITY SameMajorVersion
  )

install(
  FILES
    "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}Config.cmake"
    "${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}ConfigVersion.cmake"
  DESTINATION
    "${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}"
  )
