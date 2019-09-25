#define BOOST_TEST_MODULE prjprops

#include <boost/test/included/unit_test.hpp>

#include <string>
#include "prjprops/prjprops.h"

BOOST_AUTO_TEST_CASE(PassTestA)
{
    size_t key_start_pos, key_eol_pos;
    std::string test = "";
    bool rc;

    test = "SET MAPC=\n";
    rc = find_key_positions(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);

    BOOST_CHECK_EQUAL(true, rc);
    BOOST_CHECK_EQUAL(   0, key_start_pos);
    BOOST_CHECK_EQUAL(   9, key_eol_pos);

    test = "abc\nSET MAPC=\nSET_NEXT";
    rc = find_key_positions(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);

    BOOST_CHECK_EQUAL(true, rc);
    BOOST_CHECK_EQUAL(   4, key_start_pos);
    BOOST_CHECK_EQUAL(  13, key_eol_pos);

    rc = write_key(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);
    BOOST_CHECK_EQUAL("abc\nSET MAPC=\\path\\to\\MAPC\nSET_NEXT", test);


    test = "abc\nSET MAPC=    \nSET_NEXT";
    rc = find_key_positions(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);
    rc = write_key(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);
    BOOST_CHECK_EQUAL("abc\nSET MAPC=\\path\\to\\MAPC\nSET_NEXT", test);


    test = "abc\nSET MAPC=         hjhg             jh                  \nSET_NEXT";
    rc = find_key_positions(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);
    rc = write_key(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);
    BOOST_CHECK_EQUAL("abc\nSET MAPC=\\path\\to\\MAPC\nSET_NEXT", test);


    test = "abc\n  REM SET MAPC=         hjhg             jh                  \nSET_NEXT";
    rc = find_key_positions(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);
    rc = write_key(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);
    BOOST_CHECK_EQUAL("abc\n  REM SET MAPC=\\path\\to\\MAPC\nSET_NEXT", test);
}

BOOST_AUTO_TEST_CASE(PassTestB)
{
    std::string test = "";
    test += "SET MAPC=\n";
    test += "SET IMCO=\n";
    test += "SET IMID=\n";
    test += "SET OSM=\n";

    write_props(&test);

    std::string expectation = "";
    expectation += "SET MAPC=\\path\\to\\MAPC\n";
    expectation += "SET IMCO=\\path\\to\\IMCO\n";
    expectation += "SET IMID=\\path\\to\\IMID\n";
    expectation += "SET OSM=\\path\\to\\OSM\n";

    BOOST_CHECK_EQUAL(expectation, test);
}

BOOST_AUTO_TEST_CASE(PassTestC)
{
    std::string test = "";
    test += "SET MAPC=C:\\irgendein pfad..zu 9nirgend2o\n";
    test += "SET IMCO=D:\\undefinierter\\pfad\n";
    test += "SET IMID=E:\\irgendein pfad..zu 9nirgend2o\\und nicht_auffindbar\n";
    test += "SET OSM=F:\\wieder\\wo\\anders\n";

    write_props(&test);

    std::string expectation = "";
    expectation += "SET MAPC=\\path\\to\\MAPC\n";
    expectation += "SET IMCO=\\path\\to\\IMCO\n";
    expectation += "SET IMID=\\path\\to\\IMID\n";
    expectation += "SET OSM=\\path\\to\\OSM\n";

    BOOST_CHECK_EQUAL(expectation, test);
}

BOOST_AUTO_TEST_CASE(PassTestD)
{
    size_t key_start_pos, key_eol_pos;
    std::string test = "";
    bool rc;

    test = "SET MAPC=123\n";
    rc = find_key_positions(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);

    rc = read_key(&test, &ProjectProperties[MAPC_PATH], &key_start_pos, &key_eol_pos);

    std::string result = std::get<e_value>(ProjectProperties[MAPC_PATH]);
    std::string expectation = "123";

    BOOST_CHECK_EQUAL(expectation, result);
}

BOOST_AUTO_TEST_CASE(PassTestE)
{
    std::string test = "";
    test += "SET MAPC=C:\\irgendein pfad..zu 9nirgend2o\n";
    test += "SET IMCO=D:\\undefinierter\\pfad\n";
    test += "SET IMID=E:\\irgendein pfad..zu 9nirgend2o\\und nicht_auffindbar\n";
    test += "SET OSM=F:\\wieder\\wo\\anders\n";

    read_props(&test);

    t_value result_MAPC = std::get<e_value>(ProjectProperties[MAPC_PATH]);
    t_value result_IMCO = std::get<e_value>(ProjectProperties[IMCO_PATH]);
    t_value result_IMID = std::get<e_value>(ProjectProperties[IMID_PATH]);
    t_value result_OSM  = std::get<e_value>(ProjectProperties[OSM_PATH]);

    t_value expectation_MAPC = "C:\\irgendein pfad..zu 9nirgend2o";
    t_value expectation_IMCO = "D:\\undefinierter\\pfad";
    t_value expectation_IMID = "E:\\irgendein pfad..zu 9nirgend2o\\und nicht_auffindbar";
    t_value expectation_OSM  = "F:\\wieder\\wo\\anders";

    BOOST_CHECK_EQUAL(expectation_MAPC, result_MAPC);
    BOOST_CHECK_EQUAL(expectation_IMCO, result_IMCO);
    BOOST_CHECK_EQUAL(expectation_IMID, result_IMID);
    BOOST_CHECK_EQUAL(expectation_OSM,  result_OSM);
}


BOOST_AUTO_TEST_CASE(PassTestF)
{
    bool rc = set_prop_val(MAPG_PATH, "\\path\\to\\MAP");
    BOOST_CHECK_EQUAL(true, rc);

    t_value result = get_prop_val(MAPG_PATH);
    BOOST_CHECK_EQUAL("\\path\\to\\MAP", result);
}

BOOST_AUTO_TEST_CASE(FailTestA)
{
    /*
    float val = 1.23;
    std::string s_val = ftofrmstdstr(val);

    BOOST_CHECK_NE("1.23", s_val);
    BOOST_CHECK_NE("1,2", s_val);
    */
}
