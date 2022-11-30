set(CLANG_WARNINGS -Wall
                   -Wextra
                   -Wpedantic
                   -Wshadow
                   -Wnon-virtual-dtor
                   -Wold-style-cast
                   -Wcast-align
                   -Wunused
                   -Woverloaded-virtual
                   -Wsign-conversion
                   -Wnull-dereference
                   -Wdouble-promotion
                   -Wformat=2
                   -Wno-c99-extensions
                   -Wno-deprecated-volatile)

option(TACHYON_OPTIONS_WARNINGS_AS_ERRORS
       "Treat compiler wargnings as errors"
       TRUE)
if(TACHYON_OPTIONS_WARNINGS_AS_ERRORS)
    set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
endif()

set(GCC_WARNINGS ${CLANG_WARNINGS}
                 -Wmisleading-indentation
                 -Wduplicated-cond
                 -Wduplicated-branches
                 -Wlogical-op
                 -Wuseless-cast)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(PROJECT_WARNINGS /W3 /wd26812 /std:c++latest)
elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
    set(PROJECT_WARNINGS ${CLANG_WARNINGS})
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(PROJECT_WARNINGS ${GCC_WARNINGS})
else()
    log_fatal("Unhandled compiler: ${CMAKE_CXX_COMPILER_ID}")
endif()

target_compile_options(CommonProjectOptions INTERFACE ${PROJECT_WARNINGS})
