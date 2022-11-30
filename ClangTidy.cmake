option(TACHYON_TOOLS_ENABLE_TIDY
       "Enable static analysis with clang-tidy"
       FALSE)
if(TACHYON_TOOLS_ENABLE_TIDY)
    find_program(PATH_CLANG_TIDY clang-tidy)
    if(PATH_CLANG_TIDY)
        log_option_enabled("clang-tidy")
        set(CMAKE_CXX_CLANG_TIDY ${PATH_CLANG_TIDY} -warnings-as-errors=*)
    else()
        log_program_missing("clang-tidy")
    endif()
else()
    log_option_disabled("clang-tidy")
endif()
