add_subdirectory(gui)
add_subdirectory(helpers)
add_subdirectory(prjprops)

add_executable(
    ${CMAKE_PROJECT_NAME}
    WIN32
    main_app.cpp
    ${PROJECT_SOURCE_DIR}/res/resource.rc
)



# target compile options
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Debug>:-g>)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Debug>:-O0>)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Release>:-O3>)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-std=gnu++17>)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -m32)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -mthreads)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -pipe)
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -Wall)

# target compile definitions
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC EXE_NAME=${CMAKE_PROJECT_NAME})
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC __GNUWIN32__)
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC __WXMSW__)
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC _WIN32_WINNT=0x0601)
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Release>:wxDEBUG_LEVEL=0>)
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC $<$<CONFIG:Debug>:wxDEBUG_LEVEL=1>)


# generate CHANGELOG from *.md to *.html (on change)
FIND_PROGRAM(PANDOC_EXECUTABLE pandoc.exe)
SET(CHANGELOG_MD   ${PROJECT_SOURCE_DIR}/CHANGELOG.md)
SET(CHANGELOG_HTML ${PROJECT_SOURCE_DIR}/res/CHANGELOG.html)
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
SET_PROPERTY(SOURCE ${PROJECT_SOURCE_DIR}/res/resource.rc APPEND PROPERTY OBJECT_DEPENDS ${CHANGELOG_HTML})



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



if(CMAKE_BUILD_TYPE STREQUAL Release)
    MESSAGE(STATUS "Do minimal size release stuff")
	FIND_PROGRAM(UPX_EXECUTABLE upx.exe)
	ADD_CUSTOM_COMMAND(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
    COMMAND ${UPX_EXECUTABLE} $<TARGET_FILE:${CMAKE_PROJECT_NAME}>
    COMMENT "Running UPX packer ..."
	)
endif()
