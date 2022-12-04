option(pitchfork_TOOL_ENABLE_IWYU "Enable IncludeWhatYouUse CMake integration." OFF)

if(pitchfork_TOOL_ENABLE_IWYU)
  find_program(IWYU_PROGRAM include-what-you-use)
  mark_as_advanced(FORCE IWYU_PROGRAM)
  if(NOT IWYU_PROGRAM)
    message(WARNING "include-what-you-use requested but executable not found")
  endif()
endif()

function(pf_target_check_iwyu target)
  if(IWYU_PROGRAM)
    set_target_properties(${target} PROPERTIES CXX_INCLUDE_WHAT_YOU_USE ${IWYU_PROGRAM})
  endif()
endfunction()
