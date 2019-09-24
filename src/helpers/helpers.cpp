#include "helpers/helpers.h"

///Writes a float number in the form xx.x
std::string ftofrmstdstr(float val)
{
    char buf[10] = "";
    snprintf(buf, 10, "%.1f", val);

    std::string str_val(buf);
    boost::replace_all(str_val, ",", "."); //Replace , with .

    return str_val;
}


std::string comma_to_dot(std::string content)
{
    boost::replace_all(content, ",", ".");
    return content;
}


std::string dot_to_comma(std::string content)
{
    boost::replace_all(content, ".", ",");
    return content;
}


std::string get_current_path(void)
{
    return fs::current_path().string();
}


void replace_all(std::string &content, const std::string to_replace, const std::string replacement)
{
    boost::replace_all(content, to_replace, replacement);
}

void write_to_file_binary(const std::string &content, const std::string path_file)
{
    std::fstream f;
    f.open(path_file, std::ios::out|std::ios::binary|std::ios::trunc);
    if (f.is_open())
    {
        f << content;
        f.close();
    }
}


void write_to_file(const std::string &content, const std::string path_file)
{
    std::fstream f;
    f.open(path_file, std::ios::out|std::ios::trunc);
    if (f.is_open())
    {
        f << content;
        f.close();
    }
}


void read_from_file(std::string &content, const std::string path_file)
{
    std::ifstream f(path_file);
    std::stringstream buffer;
    buffer << f.rdbuf();

    content = buffer.str();
}


void get_resource_file(std::string &content, const wchar_t *identifier)
{
    HRSRC a_resource = FindResource(0, identifier, RT_RCDATA);
    if (a_resource != 0)
    {
        HGLOBAL  a_resHandle = LoadResource(NULL, a_resource);
        if (a_resHandle != 0)
        {
            DWORD res_size = SizeofResource(0, a_resource);
            auto firstByte = reinterpret_cast<const char*>(LockResource(a_resHandle));

            std::stringstream ss;
            ss.write(firstByte, res_size);
            content = ss.str();
            replace_all(content, "\r\n", "\n");
        }
    }
}


void write_resource_file(const wchar_t *identifier, const std::string path_file)
{
    HRSRC a_resource = FindResource(0, identifier, RT_RCDATA);
    if (a_resource != 0)
    {
        HGLOBAL  a_resHandle = LoadResource(NULL, a_resource);
        if (a_resHandle != 0)
        {
            DWORD res_size = SizeofResource(0, a_resource);

            std::fstream f;
            f.open(path_file, std::ios::out|std::ios::binary|std::ios::trunc);
            if (f.is_open())
            {
                auto firstByte = reinterpret_cast<const char*>(LockResource(a_resHandle));
                f.write(firstByte, res_size);
                f.close();
            }
        }
    }
}


int abstract(std::string &content, const std::string key, std::string &abstraction)
{
    std::string the_start_key = "REM Start ***** " + key + " *****";
    std::string the_end_key   = "REM End ******* " + key + " *****";
    int start_pos = content.find_first_of(the_start_key);
    int end_pos   = content.find_first_of(the_end_key);
    abstraction = content.substr(start_pos, end_pos-start_pos);
    return 0;
}

int intake(std::string &content, const std::string key, const std::string &record)
{
    return 0;
}


void test(void)
{
    write_resource_file(L"CURL_BINARY", "curl.exe");

    std::string str = "Meet the new boss...";
    std::hash<std::string> hash_fn;
    size_t str_hash = hash_fn(str);

}
