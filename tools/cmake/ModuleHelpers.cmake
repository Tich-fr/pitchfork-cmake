
# =============================================================================
# Function: split_unit_files
#
# Check a list of modules and tries to detect the sources, headers and
# tests files.
# C++ extension for compialtion units must be ".cxx".
# A unit does not necessarily need to have a unit test.
#
# In:
#    UNITS List of unit names to process
# Out:
#    OUT_CLASSES name of the variable holding the list of compilation unit files
#    OUT_HEADERS name of the variable holding the list of unit headers
#    OUT_TESTS name of the variable holding the list of unit tests
# -----------------------------------------------------------------------------
function(split_unit_files)
  set(options)
  set(oneValueArgs OUT_CLASSES OUT_HEADERS OUT_TESTS)
  set(multiValueArgs UNITS)
  cmake_parse_arguments(FN_ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  if(DEFINED FN_ARGS_KEYWORDS_MISSING_VALUES
    OR NOT DEFINED FN_ARGS_OUT_CLASSES
    OR NOT DEFINED FN_ARGS_OUT_HEADERS
    OR NOT DEFINED FN_ARGS_OUT_TESTS
    OR NOT DEFINED FN_ARGS_UNITS)
    message(FATAL_ERROR "Missing arguments when calling `split_unit_files`")
    return()
  endif()

  set(classes "")
  set(headers "")
  set(tests "")
  foreach(unit ${FN_ARGS_UNITS})
    set(class "${CMAKE_CURRENT_SOURCE_DIR}/${unit}.cxx")
    set(header "${CMAKE_CURRENT_SOURCE_DIR}/${unit}.h")

    if (EXISTS "${class}" AND EXISTS "${header}")
      list(APPEND classes "${unit}.cxx")
      list(APPEND headers "${unit}.h")

      if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${unit}_test.cxx")
        list(APPEND tests "${unit}_test.cxx")
      endif()
    endif()
  endforeach()

  set(${FN_ARGS_OUT_CLASSES} ${classes} PARENT_SCOPE)
  set(${FN_ARGS_OUT_HEADERS} ${headers} PARENT_SCOPE)
  set(${FN_ARGS_OUT_TESTS} ${tests} PARENT_SCOPE)
endfunction()

# =============================================================================
# Function: aggregate_unit_tests
#
# Merge a list of test files into a single executable.
#
# In:
#   (1:submoduleName) name of the module these tests belongs to
#   (2:testList) all unit tests, as a list
# -----------------------------------------------------------------------------
function(aggregate_unit_tests submoduleName testList)
  set(testName "${submoduleName}_unitTests")
  create_test_sourcelist(
    tests "${testName}.cxx"
    ${testList}
    )

  add_executable(${testName} ${tests})
  target_link_libraries(${testName}
    PRIVATE
      ${submoduleName}
      Catch2::Catch2)
  remove(tests "${testName}.cxx")

  foreach(test ${tests})
    get_filename_component(fName ${test} NAME_WE)
    add_test(NAME ${fName} COMMAND ${testName} ${fName})
  endforeach ()
endfunction()
