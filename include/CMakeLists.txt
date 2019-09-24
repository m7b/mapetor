# generate svn_version.h (always built)
SET(SVN_HEADER_TMPL ${PROJECT_SOURCE_DIR}/include/svn_version.tmpl)
SET(SVN_HEADER_H    ${PROJECT_SOURCE_DIR}/include/svn_version.h)
ADD_CUSTOM_TARGET(
    svnheader
	ALL
    COMMAND subwcrev ${PROJECT_SOURCE_DIR} ${SVN_HEADER_TMPL} ${SVN_HEADER_H} -q > nul
    COMMENT "Write subversion information in header file: ${SVN_HEADER_H}"
)
