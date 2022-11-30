option(TACHYON_TOOLS_ENABLE_TAGS
       "Enable automatic tags generation with ctags"
       TRUE)
if(TACHYON_TOOLS_ENABLE_TAGS)
    find_program(PATH_CTAGS ctags)
    if(PATH_CTAGS)
        log_option_enabled("tags")
        add_custom_target(tags_generation ALL
            COMMAND ${PATH_CTAGS} -R --fields=+iaS --extras=+q --kinds-C++=+l --language-force=C++ -f ${CMAKE_SOURCE_DIR}/tags ${CMAKE_SOURCE_DIR}/src
                COMMENT "Generating tags file...")
    else()
        log_program_missing("ctags")
    endif()
else()
    log_option_disabled("tags")
endif()
