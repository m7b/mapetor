# generate .mo from .po (on change)
FIND_PROGRAM(MSGFMT_EXECUTABLE msgfmt)
ADD_CUSTOM_COMMAND(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/de_DE.mo
    COMMAND ${MSGFMT_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/de_DE.po -o ${CMAKE_CURRENT_BINARY_DIR}/de_DE.mo
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/de_DE.po
)
ADD_CUSTOM_TARGET(
    locales
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/de_DE.mo
    COMMENT "Create translation binaries (MO files)"
)
SET_PROPERTY(SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/../res/resource.rc APPEND PROPERTY OBJECT_DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/de_DE.mo)