Include(FetchContent)

# =========================================================================== #
#                                   Catch2                                    #
# =========================================================================== #
FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        v3.1.1)
FetchContent_MakeAvailable(Catch2)
# Make Catch2 CMake functions available, as of v3.1.1
list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
