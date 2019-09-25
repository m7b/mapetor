#ifndef VERSION_H_INCLUDED
#define VERSION_H_INCLUDED

//todo: #include "svn_version.h"
#define SVN_LOCAL_MODIFICATIONS 0
#define SVN_REVISION            1234
#define SVN_TIME_NOW            01.01.1970

#define STRINGIZE2(s) #s
#define STRINGIZE(s) STRINGIZE2(s)

#define VER_COMPANY_NAME_STR        "mjbsoft"
#define AUTHOR                      "Mark Buttig"

#define VERSION_MAJOR               0
#define VERSION_MINOR               0
#define VERSION_REVISION            2
#define VERSION_DEV_STAGE           " (Pre-alpha)"  // " (Pre-alpha)" " (Alpha)" " (Beta)"
#define VERSION_BUILD               SVN_REVISION

#if SVN_LOCAL_MODIFICATIONS
  #define VERSION_MODIFIER "M"
#else
  #define VERSION_MODIFIER
#endif

#if defined (__WXDEBUG__)
  #define VERSION_BUILD_TYPE "D"
#else
  #define VERSION_BUILD_TYPE
#endif

#define VER_FILE_DESCRIPTION_LONG_STR "Application to generate custom maps"
#define VER_FILE_DESCRIPTION_STR      "Build: " STRINGIZE(SVN_TIME_NOW) " from rev. " STRINGIZE(SVN_REVISION)
#define VER_FILE_VERSION              VERSION_MAJOR, VERSION_MINOR, VERSION_REVISION, VERSION_BUILD
#define VER_FILE_VERSION_STR          STRINGIZE(VERSION_MAJOR)        \
                                      "." STRINGIZE(VERSION_MINOR)    \
                                      "." STRINGIZE(VERSION_REVISION) \
                                      " " VERSION_MODIFIER VERSION_BUILD_TYPE VERSION_DEV_STAGE

#define VER_PRODUCTNAME_STR           "Territory Card Generator"
#define VER_PRODUCT_VERSION           VER_FILE_VERSION
#define VER_PRODUCT_VERSION_STR       VER_FILE_VERSION_STR

#define VER_EXEC_FILENAME_STR         STRINGIZE(EXE_NAME)

#if LIBRARY_EXPORTS
  #define VER_ORIGINAL_FILENAME_STR VER_EXEC_FILENAME_STR ".dll"
#else
  #define VER_ORIGINAL_FILENAME_STR VER_EXEC_FILENAME_STR ".exe"
#endif
#define VER_INTERNAL_NAME_STR       VER_ORIGINAL_FILENAME_STR

#define VER_COPYRIGHT_STR             "Copyright � mjbsoft"

#ifdef _DEBUG
  #define VER_VER_DEBUG             VS_FF_DEBUG
#else
  #define VER_VER_DEBUG             0
#endif

#define VER_FILEOS                  VOS_NT_WINDOWS32
#define VER_FILEFLAGS               VER_VER_DEBUG

#if LIBRARY_EXPORTS
  #define VER_FILETYPE              VFT_DLL
#else
  #define VER_FILETYPE              VFT_APP
#endif



#endif // VERSION_H_INCLUDED
