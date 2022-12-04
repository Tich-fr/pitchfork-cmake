# WIP: this file is still very much in a WORK-IN-PROGRESS state,
# and will be the main experiment for being able to aggregate
# multiple fragments together

# pf_define_submodule(pitchfork-widgets SHARED
  # UNITS
    # MainWidget
# )
#
find_package(Qt5 REQUIRED COMPONENTS Core Widgets)

set(libraryName "pitchfork-widgets")
set(aliasName "pitchfork::widgets")
add_library("${libraryName}" SHARED MainWidget.cxx MainWidget.h)
add_library("${aliasName}" ALIAS "${libraryName}")

# set CXX_CLANG_TIDY ... flags for all checks n stuff
pf_target_sanitize(${libraryName})
pf_target_check_clangtidy(${libraryName})
pf_target_check_iwyu(${libraryName})

target_include_directories("${libraryName}"
  PUBLIC
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}>
)
set_target_properties("${libraryName}" PROPERTIES
  VERSION "${CMAKE_PROJECT_VERSION}"
  PUBLIC_HEADER "${headers}"
)
target_link_libraries("${libraryName}"
  PUBLIC
    Qt5::Widgets
    pitchfork::core
)

qt5_wrap_cpp(mocSources
  MainWidget.h
  TARGET "${libraryName}"
)
add_library(mocLibrary OBJECT ${mocSources})
pf_target_sanitize(mocLibrary)

target_include_directories(mocLibrary
  PUBLIC
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(mocLibrary
  PUBLIC
    Qt5::Widgets
)
set_target_properties(mocLibrary PROPERTIES
  VERSION "${CMAKE_PROJECT_VERSION}"
)
target_sources("${libraryName}" PRIVATE $<TARGET_OBJECTS:mocLibrary>)

configure_file(MainWidget.h
  "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}/${CMAKE_PROJECT_NAME}/MainWidget.h"
  COPYONLY
)
