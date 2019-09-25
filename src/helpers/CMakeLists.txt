FIND_PACKAGE(Boost 1.70.0 REQUIRED filesystem)

add_library(
	helpers
    helpers.cpp
)

target_link_libraries(
	helpers
	${Boost_LIBRARIES}
)