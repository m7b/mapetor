#define BOOST_TEST_MODULE helpers
#include <winsock2.h>

//#include <boost/test/included/unit_test.hpp>
#include <boost/test/unit_test.hpp>

#include "helpers/helpers.h"
#include <string>

BOOST_AUTO_TEST_CASE(PassTest)
{
    float val = 1.23;
    std::string s_val = ftofrmstdstr(val);

    BOOST_CHECK_EQUAL("1.2", s_val);
}

BOOST_AUTO_TEST_CASE(FailTest)
{
    float val = 1.23;
    std::string s_val = ftofrmstdstr(val);

    BOOST_CHECK_NE("1.23", s_val);
    BOOST_CHECK_NE("1,2", s_val);
}
