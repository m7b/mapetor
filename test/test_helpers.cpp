#define BOOST_TEST_MODULE helpers
#include <boost/test/unit_test.hpp>

#include <string>
#include "helpers/helpers.h"

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
