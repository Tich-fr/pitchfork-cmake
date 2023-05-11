# =============================================================================
# Function: hide_variables
# -----------------------------------------------------------------------------
function(hide_variables Pattern)
  get_cmake_property(all_variables VARIABLES)
  foreach(variable ${all_variables})
    if("${variable}" MATCHES "${Pattern}")
      mark_as_advanced(FORCE "${variable}")
    endif()
  endforeach()
endfunction()
