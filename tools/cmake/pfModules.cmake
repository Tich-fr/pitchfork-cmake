# Copyright 2022, Timothee Chabat
# SPDX-License-Identifier: MIT

# =============================================================================
# Function: pf_add_submodule
# -----------------------------------------------------------------------------
function(pf_add_submodule submoduleName)
  set(options)
  set(oneValueArgs)
  set(multiValueArgs PUBLIC_COMPONENTS PRIVATE_COMPONENTS FRAGMENTS DEPENDENCIES)
  cmake_parse_arguments(args "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  if (NOT args_PUBLIC_COMPONENTS
    AND NOT args_PRIVATE_COMPONENTS
    AND NOT args_FRAGMENTS)
    message(FATAL_ERROR "'pf_add_submodule: sources cannot be empty.")
  endif()

  _pf_split_component_files(
    COMPONENTS "${args_PUBLIC_COMPONENTS}"
    OUT_CLASSES publicClasses
    OUT_HEADERS publicHeaders
    OUT_TESTS publicTests
  )
  _pf_split_component_files(
    COMPONENTS "${args_PRIVATE_COMPONENTS}"
    OUT_CLASSES privateClasses
    OUT_HEADERS privateHeaders
    OUT_TESTS privateTests
  )

  _pf_add_library("${submoduleName}"
    PUBLIC_CXX "${publicClasses}"
    PRIVATE_CXX "${privateClasses}"
    PUBLIC_HEADERS "${publicHeaders}"
    PRIVATE_HEADERS "${privateHeaders}"
    DEPENDENCIES "${args_DEPENDENCIES}"
  )

  set(targetsToExport "${CMAKE_PROJECT_NAME}_${submoduleName}")
  target_link_libraries("${targetsToExport}" ${args_FRAGMENTS})

  foreach(fragment ${args_FRAGMENTS})
    if(NOT "${fragment}" STREQUAL "PUBLIC" AND NOT "${fragment}" STREQUAL "PRIVATE" AND NOT "${fragment}" STREQUAL "INTERFACE")
      if(NOT TARGET ${fragment})
        message(FATAL_ERROR "Couldn't find fragment ${fragment}.")
      else()
        get_target_property(fragmentTarget ${fragment} ALIASED_TARGET)
        if(NOT fragmentTarget)
          set(fragmentTarget ${fragment})
        endif()
        list(APPEND targetsToExport "${fragmentTarget}")
      endif()
    endif()
  endforeach()

  set(exportName "${CMAKE_PROJECT_NAME}-${submoduleName}-Targets")
  install(TARGETS ${targetsToExport}
    EXPORT "${exportName}"
    RUNTIME
      DESTINATION "${CMAKE_INSTALL_BINDIR}"
      COMPONENT ${CMAKE_PROJECT_NAME}_Runtime
    LIBRARY
      DESTINATION "${CMAKE_INSTALL_LIBDIR}"
      COMPONENT ${CMAKE_PROJECT_NAME}_Runtime
      NAMELINK_COMPONENT ${CMAKE_PROJECT_NAME}_Devel
    ARCHIVE
      DESTINATION "${CMAKE_INSTALL_LIBDIR}"
      COMPONENT ${CMAKE_PROJECT_NAME}_Devel
    PUBLIC_HEADER
      DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${CMAKE_PROJECT_NAME}"
      COMPONENT ${CMAKE_PROJECT_NAME}_Devel
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )

  install(EXPORT "${exportName}"
    NAMESPACE "${CMAKE_PROJECT_NAME}::"
    FILE "${exportName}.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}"
    COMPONENT ${CMAKE_PROJECT_NAME}_Devel
  )

  export(EXPORT "${exportName}"
    FILE "${CMAKE_BINARY_DIR}/${exportName}.cmake"
  )

endfunction()

# =============================================================================
# Function: pf_add_submodule_fragment
# -----------------------------------------------------------------------------
function(pf_add_submodule_fragment fragmentName)
  set(options)
  set(oneValueArgs)
  set(multiValueArgs PUBLIC_COMPONENTS PRIVATE_COMPONENTS DEPENDENCIES)
  cmake_parse_arguments(args "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  if (NOT args_PUBLIC_COMPONENTS
    AND NOT args_PRIVATE_COMPONENTS)
    message(FATAL_ERROR "'pf_add_submodule_fragment: sources cannot be empty.")
  endif()

  _pf_split_component_files(
    COMPONENTS "${args_PUBLIC_COMPONENTS}"
    OUT_CLASSES publicClasses
    OUT_HEADERS publicHeaders
    OUT_TESTS publicTests
  )
  _pf_split_component_files(
    COMPONENTS "${args_PRIVATE_COMPONENTS}"
    OUT_CLASSES privateClasses
    OUT_HEADERS privateHeaders
    OUT_TESTS privateTests
  )

  _pf_add_library("${fragmentName}"
    LIBRARY_TYPE OBJECT
    PUBLIC_CXX "${publicClasses}"
    PRIVATE_CXX "${privateClasses}"
    PUBLIC_HEADERS "${publicHeaders}"
    PRIVATE_HEADERS "${privateHeaders}"
    DEPENDENCIES "${args_DEPENDENCIES}"
  )
endfunction()

# =============================================================================
# Function: _pf_add_library
# -----------------------------------------------------------------------------
include(GenerateExportHeader)
function(_pf_add_library libName)
  set(options)
  set(oneValueArgs LIBRARY_TYPE)
  set(multiValueArgs PUBLIC_CXX PRIVATE_CXX PUBLIC_HEADERS PRIVATE_HEADERS DEPENDENCIES)
  cmake_parse_arguments(args "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  if (NOT args_PUBLIC_CXX
    AND NOT args_PRIVATE_CXX
    AND NOT args_PUBLIC_HEADERS
    AND NOT args_PRIVATE_HEADERS)
    message(FATAL_ERROR "'_pf_create_library: sources cannot be empty.")
  endif()

  set(targetName "${CMAKE_PROJECT_NAME}_${libName}")
  add_library(${targetName} ${args_LIBRARY_TYPE} ${args_PUBLIC_CXX} ${args_PRIVATE_CXX} ${args_PUBLIC_HEADERS} ${args_PRIVATE_HEADERS})
  pf_target_sanitize(${targetName})
  pf_target_check_clangtidy(${targetName})
  pf_target_check_iwyu(${targetName})
  pf_target_check_lwyu(${targetName})

  # Create a nice alias for library users
  add_library("${CMAKE_PROJECT_NAME}::${libName}" ALIAS "${targetName}")

  target_include_directories("${targetName}"
    PUBLIC
      $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
      $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
      $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/private_include>
  )

  if (args_DEPENDENCIES AND NOT "${args_DEPENDENCIES}" STREQUAL "")
    target_link_libraries("${targetName}" ${args_DEPENDENCIES})
  endif()

  set_target_properties(${targetName} PROPERTIES
    EXPORT_NAME "${libName}"
    VERSION "${CMAKE_PROJECT_VERSION}"
    SOVERSION "${CMAKE_PROJECT_VERSION_MAJOR}"
    PUBLIC_HEADER "${publicHeaders}"
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
  )

  set(exportHeaderFile "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}/${CMAKE_PROJECT_NAME}/${CMAKE_PROJECT_NAME}${libName}_export.h")
  generate_export_header("${targetName}"
    BASE_NAME "${CMAKE_PROJECT_NAME}${libName}"
    EXPORT_FILE_NAME "${exportHeaderFile}"
  )
  install(FILES "${exportHeaderFile}"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${CMAKE_PROJECT_NAME}"
    COMPONENT ${CMAKE_PROJECT_NAME}_Devel)

  if (BUILD_TESTING)
    pf_add_submodule_tests("${targetName}" "${publicTests};${privateTests}")
  endif()

  foreach(header ${publicHeaders})
    configure_file("${header}" "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_INCLUDEDIR}/${CMAKE_PROJECT_NAME}/${header}"
      COPYONLY
    )
  endforeach()
  foreach(header ${privateHeaders})
    configure_file("${header}" "${CMAKE_BINARY_DIR}/private_include/${header}"
      COPYONLY
    )
  endforeach()
endfunction()

# =============================================================================
# Function: pf_add_submodule_tests
#
# Register a list of unitary test file against CTest and create their executable
#
# In:
#   (1:submoduleName) name of the module these tests belongs to
#   (2:testList) all unit tests, as a list
# -----------------------------------------------------------------------------
function(pf_add_submodule_tests submoduleName testList)
  foreach(testFile ${testList})
    get_filename_component(componentName ${testFile} NAME_WE)
    set(testName "$test_{submoduleName}_${componentName}")

    add_executable(${testName} ${testFile})
    target_link_libraries(${testName}
      PRIVATE
        ${submoduleName}
        Catch2::Catch2WithMain)
    catch_discover_tests(${testName})
  endforeach ()
endfunction()

# =============================================================================
# Function: _pf_split_component_files
#
# Check a list of modules and tries to detect the sources, headers and
# tests files.
# C++ extension for compilation COMPONENTS must be ".cxx".
# A unit does not necessarily need to have a unit test nor a cxx file, but must
# at least have a ".h" file.
#
# In:
#    COMPONENTS List of components to process
# Out:
#    OUT_CLASSES name of the variable holding the list of compilation unit files
#    OUT_HEADERS name of the variable holding the list of unit headers
#    OUT_TESTS name of the variable holding the list of unit tests
# -----------------------------------------------------------------------------
function(_pf_split_component_files)
  set(options)
  set(oneValueArgs OUT_CLASSES OUT_HEADERS OUT_TESTS)
  set(multiValueArgs COMPONENTS)
  cmake_parse_arguments(args "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  if(NOT DEFINED args_OUT_CLASSES
    OR NOT DEFINED args_OUT_HEADERS
    OR NOT DEFINED args_OUT_TESTS
  )
    message(FATAL_ERROR "Missing arguments when calling `_pf_split_component_files`")
    return()
  endif()

  set(classes "")
  set(headers "")
  set(tests "")
  foreach(component ${args_COMPONENTS})
    if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${component}.h")
      message(FATAL_ERROR "Missing header file '${component}.h'")
    endif()

    list(APPEND headers "${component}.h")
    if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${component}.cxx")
      list(APPEND classes "${component}.cxx")
    endif()
    if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${component}.test.cxx")
      list(APPEND tests "${component}.test.cxx")
    endif()
  endforeach()

  set(${args_OUT_CLASSES} ${classes} PARENT_SCOPE)
  set(${args_OUT_HEADERS} ${headers} PARENT_SCOPE)
  set(${args_OUT_TESTS} ${tests} PARENT_SCOPE)
endfunction()
