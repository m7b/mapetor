cmake_minimum_required(VERSION 3.0)
project (TMGR_CardCreator)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

## wxWidgets
SET(wxWidgets "wxWidgets-3.1.2")
SET(CMAKE_FIND_LIBRARY_PREFIXES "lib")
SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
SET(wxWidgets_ROOT_DIR "C:/CPP/tools/msys64/mingw64/include/wx-3.0")
SET(wxWidgets_LIB_DIR "C:/CPP/tools/msys64/mingw64/lib")
SET(wxWidgets_CONFIGURATION mswu)
FIND_PACKAGE(wxWidgets REQUIRED richtext adv html core xml base)
INCLUDE("${wxWidgets_USE_FILE}")


## Boost
SET(Boost "boost_1_70_0")
#SET(Boost_DEBUG ON)
SET(Boost_COMPILER "-mgw81")
#http://www.boost.org/doc/libs/1_67_0/more/getting_started/windows.html#library-naming
SET(Boost_Architecture_and_address_model_tag "-x32")
#---------------------------------------------------
SET(BOOST_ROOT "W:/${Boost}")
SET(BOOST_INCLUDEDIR "W:/${Boost}")
SET(BOOST_LIBRARYDIR "W:/${Boost}/stage/lib")
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
add_subdirectory(include)
add_subdirectory(src)

ADD_DEPENDENCIES(${CMAKE_PROJECT_NAME} svnheader locales doc)