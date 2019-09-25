add_library(
	helpers
    helpers.cpp
)

target_link_libraries(
	helpers
	${Boost_LIBRARIES}
)