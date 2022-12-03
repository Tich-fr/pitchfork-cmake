include(ModuleHelpers)

# Include all submodules and optional submodules
add_subdirectory(core)

option(pitchfork_MODULE_ENABLE_OPT "Enable the opt module" ON)
if (pitchfork_MODULE_ENABLE_OPT)
  add_subdirectory(opt)
endif()
