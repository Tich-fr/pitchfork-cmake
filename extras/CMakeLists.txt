include(ModuleHelpers)

option(pitchfork_EXTRAS_ENABLE_GUI "Enable building a Qt GUI for for the library" OFF)
if (pitchfork_EXTRAS_ENABLE_GUI)
  add_subdirectory(gui)
endif()
