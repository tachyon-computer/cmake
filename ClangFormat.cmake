option(TACHYON_TOOLS_ENABLE_FORMATTING
       "Enable automatic code formatting with clang-format"
       TRUE)
if(TACHYON_TOOLS_ENABLE_FORMATTING)
    find_program(PATH_CLANG_FORMAT clang-format)
    if(PATH_CLANG_FORMAT)
        log_option_enabled("formatting")
    else()
        log_program_missing("clang-format")
    endif()
else()
    log_option_disabled("formatting")
endif()

function(add_format_target TARGET)
    if(TACHYON_TOOLS_ENABLE_FORMATTING)
        get_target_property(TARGET_DIR ${TARGET} SOURCE_DIR)
        get_target_property(TARGET_SOURCES ${TARGET} SOURCES)

        foreach(FILE ${TARGET_SOURCES})
            get_filename_component(FILE ${FILE} REALPATH BASE_DIR ${TARGET_DIR})
            list(APPEND FORMAT_SOURCES ${FILE})
        endforeach()

        set(FORMAT_TARGET_NAME ${TARGET}_format)

        add_custom_target(${FORMAT_TARGET_NAME}
                          COMMAND ${PATH_CLANG_FORMAT} -i -style=file ${FORMAT_SOURCES}
                          COMMENT "Formatting ${TARGET}...")

        add_dependencies(${TARGET} ${FORMAT_TARGET_NAME})
    endif()
endfunction()
