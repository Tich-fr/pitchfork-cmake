# Submodule names should follow the rules you set for your cmake config files.
# If you want to use the "myproject-config.cmake" syntax then name your targets : myproject-module[<-namespace>...]
# If you want to use the "myprojectConfig.cmake" syntax then name your targets : myprojectModule[<Namespace>...]
# Here I'm using the 2nd syntax
set(target_name pitchforkCore)

# This function is just a helper to create separately the list of all source / header / test files.
# See definition in 'tools/cmake/ModuleHelpers.cmake'
split_unit_files(
  UNITS
    Point
  OUT_CLASSES classes
  OUT_HEADERS headers
  OUT_TESTS tests
  )

# Contains the 'core' implementation of the 'dag' namespace.
# The subdirectory containing a namespace creates an OBJECT library
# suitable to use for creating the current component library.
add_subdirectory(dag)

# Define the library
add_library(${target_name} SHARED
  ${classes}
  $<TARGET_OBJECTS:pitchfork::core::dag>
  )
add_library(pitchfork::core ALIAS ${target_name})

target_include_directories(${target_name}
  INTERFACE
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${pitchfork_bin_includedir}>
  )

set_target_properties(${target_name} PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
  PUBLIC_HEADER ${headers}
  EXPORT_NAME pitchfork::core
  )

# install libs and headers
set(exportName "${target_name}Config")
install(TARGETS ${target_name}
  EXPORT ${exportName}
  LIBRARY
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
  PUBLIC_HEADER
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${CMAKE_PROJECT_NAME}"
  )
install(EXPORT ${exportName}
  FILE ${exportName}.cmake
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}"
  )
export(EXPORT ${exportName}
  FILE "${CMAKE_BINARY_DIR}/${exportName}.cmake"
  )

# Here we move all public headers to the build directory. This is so the EXACT SAME external
# can compile against either the build directory or the install directory.
# What I'm aiming for is something like :
#
# #include <pitchfork/Point.h>     // for example
#
# While this layout is enforced during the install step there is no such layout in this library
# source directory because I choosed to put the headers as close as possible from the sources.
# That means we have to create this include directory by hand when building.
#
# Note that this is this directory that is used at build time in `target_include_directories`
foreach(header ${headers})
  configure_file(${header} "${pitchfork_bin_includedir}/${CMAKE_PROJECT_NAME}/${header}"
    COPYONLY
    )
endforeach()
