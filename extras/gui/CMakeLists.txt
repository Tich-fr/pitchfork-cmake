add_subdirectory(widgets)

add_executable(Cutlery Cutlery_main.cxx)

pf_target_sanitize(Cutlery)
pf_target_check_clangtidy(Cutlery)
pf_target_check_iwyu(Cutlery)

target_link_libraries(Cutlery
  PUBLIC
    pitchfork::widgets)

if (APPLE)
  set(rbase "@executable_path")
else ()
  set(rbase "$ORIGIN")
endif ()
set_target_properties(Cutlery PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
  INSTALL_RPATH "${rbase}/../${CMAKE_INSTALL_LIBDIR}"
  EXPORT_NAME "cutlery"
  )

set(exportName "cutlery-config")
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
