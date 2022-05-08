set(classes
    Graph.cxx)

set(headers
    Graph.h)

add_library(AdagioCore SHARED ${classes})
add_library(Adagio::Core ALIAS AdagioCore)

target_include_directories(AdagioCore
  PUBLIC
    $<INSTALL_INTERFACE:>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

set_target_properties(AdagioCore PROPERTIES
    VERSION 0.0.1
    PUBLIC_HEADER ${headers})

include(GNUInstallDirs)

install(TARGETS AdagioCore
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})