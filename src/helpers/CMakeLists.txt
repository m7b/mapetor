add_library(
	helpers
    helpers.cpp
)

target_link_libraries(
	helpers
	${Boost_LIBRARIES}
)

target_compile_options(helpers PUBLIC $<$<COMPILE_LANGUAGE:CXX>:-std=gnu++17>)