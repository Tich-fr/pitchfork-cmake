set(target_name pitchforkWidgets)

split_unit_files(
  UNITS
    MainWidget
  OUT_CLASSES classes
  OUT_HEADERS headers
  OUT_TESTS tests
  )

add_library(${target_name} OBJECT ${classes})
add_library(pitchfork::widgets ALIAS ${target_name})

target_include_directories(${target_name}
  PUBLIC
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${pitchfork_bin_includedir}>
  )

find_package(Qt5 REQUIRED COMPONENTS Widgets)
target_link_libraries(${target_name}
  PUBLIC
    Qt5::Widgets
    pitchfork::core
  )

set_target_properties(${target_name} PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
  PUBLIC_HEADER ${headers}
  EXPORT_NAME pitchfork::widgets
  AUTOMOC ON
  AUTOUIC ON
  )

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

foreach(header ${headers})
  configure_file(${header} "${pitchfork_bin_includedir}/${CMAKE_PROJECT_NAME}/${header}"
    COPYONLY
    )
endforeach()
