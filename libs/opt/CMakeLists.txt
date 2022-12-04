set(target_name pitchforkOpt)

split_unit_files(
  UNITS
    Hidden
  OUT_CLASSES classes
  OUT_HEADERS headers
  OUT_TESTS tests
  )

add_library(${target_name} SHARED ${classes})
add_library(pitchfork::opt ALIAS ${target_name})

target_include_directories(${target_name}
  PUBLIC
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${pitchfork_bin_includedir}>
  )

set_target_properties(${target_name} PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
  PUBLIC_HEADER ${headers}
  EXPORT_NAME pitchfork::opt
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
