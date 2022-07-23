find_package(Doxygen REQUIRED)

# Build public API documentation with doxygen.
# Configuration is done by editing `Doxyfile.in`
file(GLOB_RECURSE all_public_headers ${pitchfork_bin_includedir}/${CMAKE_PROJECT_NAME}/*.h)

set(pitchfork_DOXYGEN_INPUT_DIR ${CMAKE_SOURCE_DIR}/libs)
set(pitchfork_DOXYFILE_IN ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
set(pitchfork_DOXYFILE_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

configure_file(${pitchfork_DOXYFILE_IN} ${pitchfork_DOXYFILE_OUT} @ONLY)

add_custom_target(DoxygenDocumentation ALL
  COMMAND ${DOXYGEN_EXECUTABLE} ${pitchfork_DOXYFILE_OUT}
  DEPENDS
    ${all_public_headers}
    ${pitchfork_DOXYFILE_OUT}
  BYPRODUCTS
    ${CMAKE_CURRENT_BINARY_DIR}/html/index.html
  COMMENT
    "Generating documentation"
  VERBATIM)
