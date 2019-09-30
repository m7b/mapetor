cmake_minimum_required(VERSION 3.0)
project (mapetor)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")


### wxWidgets
IF(WIN32)
    SET(wxWidgets "wxWidgets-3.0.4")
    SET(CMAKE_FIND_LIBRARY_PREFIXES "lib")
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    SET(wxWidgets_ROOT_DIR "C:/CPP/extlibs/${wxWidgets}")
    SET(wxWidgets_LIB_DIR "C:/CPP/extlibs/${wxWidgets}/lib/gcc_lib")
    SET(wxWidgets_CONFIGURATION mswu)
ELSE()
    SET(wxWidgets_USE_DEBUG OFF)
    SET(wxWidgets_USE_UNICODE ON)
    SET(wxWidgets_USE_UNIVERSAL OFF)
    SET(wxWidgets_USE_STATIC ON)
    #SET(wxWidgets_CONFIG_OPTIONS --toolkit=base)
endif(WIN32)
FIND_PACKAGE(wxWidgets REQUIRED richtext adv html core xml base)
INCLUDE("${wxWidgets_USE_FILE}")


IF (NOT WIN32)
    find_program(WX_CONFIG
            NAMES wx-config-3.0 wx-config-2.9 wx-config
            PATHS
                /usr/bin
                /usr/local/bin
        )

    execute_process(
        COMMAND ${WX_CONFIG} "--cxxflags"
        OUTPUT_VARIABLE WX_INC_OPTS
    )
    MESSAGE("WX Inc: ${WX_INC_OPTS}")

    execute_process(
        COMMAND ${WX_CONFIG} "--libs" "std,aui"
        OUTPUT_VARIABLE WX_LIB_OPTS
    )
    MESSAGE("WX Lib: ${WX_LIB_OPTS}")

    execute_process(
        COMMAND ${WX_CONFIG} "--libs --toolkit=base-unicode-3.0"
        OUTPUT_VARIABLE WX_TOOLKIT
    )
    MESSAGE("WX Lib: ${WX_TOOLKIT}")
ENDIF(NOT WIN32)



## Boost
#SET(Boost_DEBUG ON)
IF(WIN32)
    SET(Boost_COMPILER "-mgw81")
    SET(Boost_ARCHITECTURE "-x32")
    SET(BOOST_ROOT "C:/CPP/extlibs/boost_1_70_0")
    SET(BOOST_INCLUDEDIR "C:/CPP/extlibs/boost_1_70_0")
    SET(BOOST_LIBRARYDIR "C:/CPP/extlibs/boost_1_70_0/stage/lib")
endif(WIN32)
SET(Boost_USE_STATIC_LIBS        ON)
SET(Boost_USE_MULTITHREADED      ON)
SET(Boost_USE_STATIC_RUNTIME    OFF)
FIND_PACKAGE(Boost 1.70.0 REQUIRED filesystem date_time)


include_directories(
    "${Boost_INCLUDE_DIRS}"
    ${PROJECT_SOURCE_DIR}/include
    ${PROJECT_SOURCE_DIR}/wxfb
)


add_subdirectory(test)
add_subdirectory(doc)
add_subdirectory(locales)
#todo: add_subdirectory(include)
add_subdirectory(src)

# the executable
add_executable(
    ${CMAKE_PROJECT_NAME}
    WIN32
    src/main_app.cpp
    ${PROJECT_SOURCE_DIR}/res/resource.rc
)


# generate CHANGELOG from *.md to *.html (on change)
FIND_PROGRAM(PANDOC_EXECUTABLE pandoc)
SET(CHANGELOG_MD   ${PROJECT_SOURCE_DIR}/CHANGELOG.md)
SET(CHANGELOG_HTML ${CMAKE_CURRENT_BINARY_DIR}/CHANGELOG.html)
ADD_CUSTOM_COMMAND(
    OUTPUT ${CHANGELOG_HTML}
    COMMAND ${PANDOC_EXECUTABLE} ${CHANGELOG_MD} -o ${CHANGELOG_HTML}
    DEPENDS ${CHANGELOG_MD}
)
ADD_CUSTOM_TARGET(
    changelog
    DEPENDS ${CHANGELOG_HTML}
    COMMENT "Create changelog file (md to html)"
)
SET_PROPERTY(SOURCE res/resource.rc APPEND PROPERTY OBJECT_DEPENDS ${CHANGELOG_HTML})



# target compile options
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Debug>:-g>)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Debug>:-O0>)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Release>:-O3>)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-std=gnu++17>)
IF(WIN32)
    target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -m32)
    target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -mthreads)
ENDIF(WIN32)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -pipe)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -Wall)

# target compile definitions
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC EXE_NAME=${CMAKE_PROJECT_NAME})
IF(WIN32)
    target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC __GNUWIN32__)
    target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC __WXMSW__)
    target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC _WIN32_WINNT=0x0601)
ELSE()
    target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC __WXGTK3__)
ENDIF(WIN32)
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Release>:wxDEBUG_LEVEL=0>)
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Debug>:wxDEBUG_LEVEL=1>)


IF(WIN32)
target_link_libraries(
    ${CMAKE_PROJECT_NAME}
    gui
    prjprops
    shlwapi
    version
    oleacc
    -static
    $<$<CONFIG:Release>:-s>
)
ELSE()
target_link_libraries(
    ${CMAKE_PROJECT_NAME}
    gui
    prjprops
    -static
    $<$<CONFIG:Release>:-s>
)
ENDIF(WIN32)



#todo ADD_DEPENDENCIES(${CMAKE_PROJECT_NAME} svnheader locales doc)
ADD_DEPENDENCIES(${CMAKE_PROJECT_NAME} locales doc changelog)


if(CMAKE_BUILD_TYPE STREQUAL Release)
    MESSAGE(STATUS "Do minimal size release stuff")
    FIND_PROGRAM(UPX_EXECUTABLE upx.exe)
    ADD_CUSTOM_COMMAND(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
    COMMAND ${UPX_EXECUTABLE} $<TARGET_FILE:${CMAKE_PROJECT_NAME}>
    COMMENT "Running UPX packer ..."
    )
endif()