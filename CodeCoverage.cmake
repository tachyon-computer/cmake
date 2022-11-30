add_library(CodeCoverage INTERFACE)

option(TACHYON_OPTIONS_ENABLE_COVERAGE
       "Enable code coverage"
       FALSE)

if(TACHYON_OPTIONS_ENABLE_COVERAGE)
    log_option_enabled("code coverage")

    target_compile_options(CodeCoverage
        INTERFACE       -O0
                        -g
                        --coverage)

    target_link_libraries(CodeCoverage
        INTERFACE       --coverage)
else()
    log_option_disabled("code coverage")
endif()
