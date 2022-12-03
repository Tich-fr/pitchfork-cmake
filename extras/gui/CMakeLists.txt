add_subdirectory(widgets)

add_executable(Cutlery Cutlery_main.cxx)

target_link_libraries(Cutlery
  PUBLIC
    pitchfork::widgets)

set_target_properties(Cutlery PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
  )

set(exportName "CutleryConfig")
install(TARGETS Cutlery
  EXPORT ${exportName}
  RUNTIME
    DESTINATION ${CMAKE_INSTALL_BINDIR}
  )
install(EXPORT ${exportName}
  FILE ${exportName}.cmake
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}"
  )
export(EXPORT ${exportName}
  FILE "${CMAKE_BINARY_DIR}/${exportName}.cmake"
  )
