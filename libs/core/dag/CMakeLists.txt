set(target_name pitchforkCoreDag)

split_unit_files(
  UNITS
    Graph
    Node
  OUT_CLASSES classes
  OUT_HEADERS headers
  OUT_TESTS tests
  )

add_library(${target_name} OBJECT ${classes})
add_library(pitchfork::core::dag ALIAS ${target_name})

target_include_directories(${target_name}
  PUBLIC
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${pitchfork_bin_includedir}>
  )

set_target_properties(${target_name} PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
  PUBLIC_HEADER "${headers}"
  )

if (BUILD_TESTING)
  register_unit_tests(${target_name} "${tests}")
endif()

install(TARGETS ${target_name}
  LIBRARY
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
  PUBLIC_HEADER
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${CMAKE_PROJECT_NAME}"
  )

foreach(header ${headers})
  configure_file(${header} "${pitchfork_bin_includedir}/${CMAKE_PROJECT_NAME}/${header}"
    COPYONLY
    )
endforeach()
