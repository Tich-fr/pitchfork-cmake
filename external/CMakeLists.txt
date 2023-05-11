include(FetchContent)
include(pfHideVariables)

# Necessary when using cmake Werror=dev, control the policy when downloading
# from an URL.
cmake_policy(SET CMP0135 NEW)

# =========================================================================== #
#                                   Catch2                                    #
# =========================================================================== #
if (BUILD_TESTING)
  FetchContent_Declare(Catch2
    URL https://github.com/catchorg/Catch2/archive/refs/tags/v3.2.0.zip
    )

  FetchContent_MakeAvailable(Catch2)

  # Make Catch2 CMake functions available, as of v3.1.1
  list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
  include(Catch)

  # Make Catch related CMake variables advanced
  hide_variables("^CATCH.*")
endif()

# Make FetchContent related CMake variables advanced
hide_variables("^FETCHCONTENT.*")
