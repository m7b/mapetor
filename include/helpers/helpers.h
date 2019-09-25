#ifndef __helpers__
#define __helpers__

#include <boost/process.hpp>

#include <windows.h>
#include <string>
#include <fstream>
#include <sstream>

#include <boost/algorithm/string/replace.hpp>

#include <boost/filesystem.hpp>
namespace fs = boost::filesystem;
//#include <filesystem>
//namespace fs = std::filesystem;


std::string ftofrmstdstr(float val);
std::string comma_to_dot(std::string content);
std::string dot_to_comma(std::string content);
std::string get_current_path(void);
void replace_all(std::string &content, const std::string to_replace, const std::string replacement);
void write_to_file_binary(const std::string &content, const std::string path_file);
void write_to_file(const std::string &content, const std::string path_file);
void read_from_file(std::string &content, const std::string path_file);
void get_resource_file(std::string &content, const wchar_t *identifier);
void write_resource_file(const wchar_t *identifier, const std::string path_file);

int abstract(std::string &content, const std::string key, std::string &abstraction);
int intake(std::string &content, const std::string key, const std::string &record);

void test(void);

#endif // __helpers__
