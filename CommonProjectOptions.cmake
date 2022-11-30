add_library(CommonProjectOptions INTERFACE)

# === BUILD TYPE ===
set_property(CACHE CMAKE_BUILD_TYPE
             PROPERTY STRINGS "Debug"
                              "Release"
                              "RelWithDebInfo")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    log_war("No build type specified, setting to RelWithDebInfo")
    set(CMAKE_BUILD_TYPE
        RelWithDebInfo
        CACHE STRING "Type of build" FORCE)
else()
    log_info("Build type: ${CMAKE_BUILD_TYPE}")
endif()

set(BUILD_SHARED_LIBS OFF)

# === CCACHE ===
option(TACHYON_OPTIONS_ENABLE_CCACHE
       "Enable ccache"
       FALSE)
if(TACHYON_OPTIONS_ENABLE_CCACHE)
    find_program(PATH_CCACHE ccache)
    if(PATH_CCACHE)
        log_option_enabled("ccache")
        set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
    else()
        log_option_disabled("ccache")
    endif()
endif()

# === LTO ===
option(TACHYON_OPTIONS_ENABLE_LTO
       "Enable link-time optimization"
       TRUE)
if(TACHYON_OPTIONS_ENABLE_LTO)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT result OUTPUT output)
    if(result)
        set_property(TARGET CommonProjectOptions PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
    else()
        log_err("LTO is not supported: ${output}")
    endif()
endif()

# === PCH ===
option(TACHYON_OPTIONS_ENABLE_PCH
       "Enable precompiled header"
       TRUE)
if(TACHYON_OPTIONS_ENABLE_PCH)
    log_option_enabled("precompiled header")
    target_precompile_headers(CommonProjectOptions INTERFACE <memory>
                                                             <string>
                                                             <vector>
                                                             <cassert>
                                                             <cstdint>)
else()
    log_option_disabled("precompiled header")
endif()

# === Misc ===
option(TACHYON_OPTIONS_BUILD_TESTING "Enable Tachyon tests" FALSE)
if(TACHYON_OPTIONS_BUILD_TESTING)
    log_option_enabled("building tests")
else()
    log_option_disabled("building tests")
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
