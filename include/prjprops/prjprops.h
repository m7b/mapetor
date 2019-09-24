#ifndef __prjprops__
#define __prjprops__

#include <string>
#include <tuple>
#include <vector>

enum prop_names
{
    MAPC_PATH = 0,
    MAPG_PATH,
    IMCO_PATH,
    IMID_PATH,
    INKS_PATH,
    CARD_ORIENTATION,
    CARD_PAPERHEIGHT_MM,
    CARD_PAPERWIDTH_MM,
    MAP_CENTER,
    MAP_SCALE,
    MAP_DPI,
    MAP_USE_GRID,
    MAP_USE_ATTRIBUTION,
    MAP_USE_SCALE,
    OSM_PATH,
    OSM_SERVICE_URL,
    OSM_GEOMETRY_BOUNDS
};


enum prop_field
{
    e_name = 0,
    e_key,
    e_value
};

typedef prop_names  t_name;
typedef std::string t_key;
typedef std::string t_value;

typedef std::tuple<const t_name, const t_key, t_value> t_SingleProp;
typedef std::vector<t_SingleProp> t_ProjectProperties;

extern t_ProjectProperties ProjectProperties;


bool find_key_positions(const std::string *prj_file, const t_SingleProp *prop, size_t *key_start_pos, size_t *key_eol_pos);

void write_props(std::string *prj_file);
bool write_key(std::string *prj_file, const t_SingleProp *prop, const size_t *key_start_pos, const size_t *key_eol_pos);

void read_props(const std::string *prj_file);
bool read_key(const std::string *prj_file, t_SingleProp *prop, const size_t *key_start_pos, const size_t *key_eol_pos);


t_value get_prop_val(const prop_names n);
bool set_prop_val(const prop_names n, const t_value val);

#endif // __prjprops__
