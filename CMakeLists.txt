cmake_minimum_required(VERSION 3.0)
project (mapetor)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")


### wxWidgets
SET(wxWidgets "wxWidgets-3.0.4")
SET(CMAKE_FIND_LIBRARY_PREFIXES "lib")
SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
SET(wxWidgets_ROOT_DIR "C:/CPP/extlibs/${wxWidgets}")
SET(wxWidgets_LIB_DIR "C:/CPP/extlibs/${wxWidgets}/lib/gcc_lib")
SET(wxWidgets_CONFIGURATION mswu)
FIND_PACKAGE(wxWidgets REQUIRED richtext adv html core xml base)
INCLUDE("${wxWidgets_USE_FILE}")


## Boost
SET(Boost_DEBUG ON)
SET(Boost_COMPILER "-mgw81")
SET(Boost_ARCHITECTURE "-x32")
#---------------------------------------------------
SET(BOOST_ROOT "C:/CPP/extlibs/boost_1_70_0")
SET(BOOST_INCLUDEDIR "C:/CPP/extlibs/boost_1_70_0")
SET(BOOST_LIBRARYDIR "C:/CPP/extlibs/boost_1_70_0/stage/lib")
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