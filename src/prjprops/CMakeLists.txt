add_library(
	prjprops
    prjprops.cpp
)

#target_link_libraries(
#	prjprops
#	${Boost_LIBRARIES}
#)

target_compile_options(prjprops PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-std=gnu++17>)