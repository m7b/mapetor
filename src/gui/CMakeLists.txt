add_library(
	gui
    C_wxDlgInfo.cpp
    C_wxMainFrame.cpp
    wxIconBundleResLoader.cpp
    ${PROJECT_SOURCE_DIR}/wxfb/C_wxfbMainFrame.cpp
    ${PROJECT_SOURCE_DIR}/wxfb/C_wxInfoDialog.cpp
)
target_compile_definitions(gui PUBLIC $<$<CONFIG:Release>:wxDEBUG_LEVEL=0>)

target_link_libraries(
	gui
	helpers
    ${wxWidgets_LIBRARIES}
)

