option(pitchfork_TOOL_ENABLE_LWYU "Enable LinkWhatYouUse CMake feature." OFF)

function(pf_target_check_lwyu target)
  set_target_properties(${target} PROPERTIES LINK_WHAT_YOU_USE ${pitchfork_TOOL_ENABLE_LWYU})
endfunction()
